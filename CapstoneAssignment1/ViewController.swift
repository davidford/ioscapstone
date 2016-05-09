//
//  ViewController.swift
//  CapstoneAssignment1
//
//  Created by David Ford on 2016-04-24.
//  Copyright © 2016 Code Ninjas. All rights reserved.
//

import UIKit
import FaceTracker

class ViewController: UIViewController, FaceTrackerViewControllerDelegate {
    
    var mode = Mode.None
    var eyesView = UIImageView()
    var hatView = UIImageView()
    var maskView = UIImageView()
    var leftEyeView = UIImageView()
    var rightEyeView = UIImageView()
    var noseView = UIImageView()
    var mouthView = UIImageView()
    var faceTrackerViewController: FaceTrackerViewController?
    var overlayViews = [String: [UIView]]()
    var leftEyeImages: [UIImage]!
    var rightEyeImages: [UIImage]!
    
    var leftEye1: UIImage!
    var leftEye2: UIImage!
    var leftEye3: UIImage!
    var leftEye4: UIImage!
    var leftEye5: UIImage!
    var leftEye6: UIImage!
    var leftEye7: UIImage!
    var leftEye8: UIImage!
    
    var rightEye1: UIImage!
    var rightEye2: UIImage!
    var rightEye3: UIImage!
    var rightEye4: UIImage!
    var rightEye5: UIImage!
    var rightEye6: UIImage!
    var rightEye7: UIImage!
    var rightEye8: UIImage!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet var faceTrackerContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.insertSubview(hatView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(maskView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(eyesView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(leftEyeView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(rightEyeView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(noseView, aboveSubview: faceTrackerContainerView)
        self.view.insertSubview(mouthView, aboveSubview: faceTrackerContainerView)
        hatView.image = UIImage(named: "tophat")
        maskView.image = UIImage(named: "groucho")
        eyesView.image = UIImage(named: "eyes")
        //leftEyeView.image = UIImage(named: "eye")
        //rightEyeView.image = UIImage(named: "eye")
        noseView.image = UIImage(named: "nose")
        mouthView.image = UIImage(named: "mouth")
        
        
        leftEye1 = UIImage(named: "eye_1")
        leftEye2 = UIImage(named: "eye_2")
        leftEye3 = UIImage(named: "eye_3")
        leftEye4 = UIImage(named: "eye_4")
        leftEye5 = UIImage(named: "eye_5")
        leftEye6 = UIImage(named: "eye_6")
        leftEye7 = UIImage(named: "eye_7")
        leftEye8 = UIImage(named: "eye_8")
        leftEyeImages = [leftEye1, leftEye2, leftEye3, leftEye4, leftEye5, leftEye6, leftEye7, leftEye8]
        leftEyeView.image = UIImage.animatedImageWithImages(leftEyeImages, duration: 0.5)
        
        rightEye1 = UIImage(named: "eye_8")
        rightEye2 = UIImage(named: "eye_7")
        rightEye3 = UIImage(named: "eye_6")
        rightEye4 = UIImage(named: "eye_5")
        rightEye5 = UIImage(named: "eye_4")
        rightEye6 = UIImage(named: "eye_3")
        rightEye7 = UIImage(named: "eye_2")
        rightEye8 = UIImage(named: "eye_1")
        leftEyeImages = [rightEye1, rightEye2, rightEye3, rightEye4, rightEye5, rightEye6, rightEye7, rightEye8]
        rightEyeView.image = UIImage.animatedImageWithImages(leftEyeImages, duration: 0.5)
        
        activityIndicator.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "embedFaceTrackerViewController") {
            faceTrackerViewController = segue.destinationViewController as? FaceTrackerViewController
            faceTrackerViewController!.delegate = self
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        faceTrackerViewController!.startTracking { () -> Void in
            self.activityIndicator.stopAnimating()
        }
    }
    
    
    @IBAction func optionsButtonClicked(sender: AnyObject) {
        let alert = UIAlertController()
        alert.popoverPresentationController?.sourceView = optionsButton
        
        alert.addAction(UIAlertAction(title: "Swap Camera", style: .Default, handler: { (action) -> Void in
            self.faceTrackerViewController!.swapCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func onHatButtonClicked(sender: AnyObject) {
        if(mode != Mode.Hat) {
            print("Hat Mode")
            hideAllViews()
            mode = Mode.Hat
        } else {
            print("No Mode")
            mode = Mode.None
        }
    }
    
    
    @IBAction func onDebugButtonClicked(sender: AnyObject) {
        if(mode != Mode.Debug) {
            print("Debug Mode")
            hideAllViews()
            mode = Mode.Debug
        } else {
            print("No Mode")
            mode = Mode.None
        }
    }
    
    @IBAction func onGrouchoButtonClicked(sender: AnyObject) {
        if(mode != Mode.Mask) {
            print("Mask Mode")
            hideAllViews()
            mode = Mode.Mask
        } else {
            print("No Mode")
            mode = Mode.None
        }
    }
    
    @IBAction func onEyesButtonClicked(sender: AnyObject) {
        if(mode != Mode.Eyes) {
            print("Eyes Mode")
            hideAllViews()
            mode = Mode.Eyes
        } else {
            print("No Mode")
            mode = Mode.None
        }
    }
    
    @IBAction func onNoseButtonClicked(sender: AnyObject) {
        if(mode != Mode.Nose) {
            print("Nose Mode")
            hideAllViews()
            mode = Mode.Nose
        } else {
            print("No Mode")
            mode = Mode.None
        }
    }
    
    
    @IBAction func onMouthButtonClicked(sender: AnyObject) {
        if(mode != Mode.Mouth) {
            print("Mouth Mode")
            hideAllViews()
            mode = Mode.Mouth
        } else {
            print("No Mode")
            mode = Mode.None
        }
    }
    
    
    func setAnchorPoint(anchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = CGPointApplyAffineTransform(newPoint, view.transform)
        oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform)
        
        var position = view.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
    
    
    func updateViewForFeature(feature: String, index: Int, point: CGPoint, bgColor: UIColor) {
        let frame = CGRectMake(point.x-2, point.y-2, 4.0, 4.0)
        
        if self.overlayViews[feature] == nil {
            self.overlayViews[feature] = [UIView]()
        }
        
        if(index < self.overlayViews[feature]!.count) {
            self.overlayViews[feature]![index].frame = frame
            self.overlayViews[feature]![index].hidden = false
            self.overlayViews[feature]![index].backgroundColor = bgColor
        } else {
            let newView = UIView(frame: frame)
            newView.backgroundColor = bgColor
            newView.hidden = false
            self.view.addSubview(newView)
            self.overlayViews[feature]! += [newView]
        }
        
    }
    
    func hideAllViews() {
        hatView.hidden = true
        maskView.hidden = true
        eyesView.hidden = true
        leftEyeView.hidden = true
        rightEyeView.hidden = true
        noseView.hidden = true
        mouthView.hidden = true
        
        for (_, views) in self.overlayViews {
            for view in views {
                view.hidden = true
            }
        }
    }
    
    func calculateDistance(pointA: CGPoint, pointB: CGPoint) -> CGFloat {
        return sqrt(pow(pointB.x - pointA.x, 2) + pow(pointB.y - pointA.y, 2))
    }
    
    func calculatePointInBetween(pointA: CGPoint, pointB: CGPoint) -> CGPoint {
        return CGPointMake((pointB.x + pointA.x) / 2, (pointB.y + pointA.y) / 2)
    }
    
    func faceTrackerDidUpdate(points: FacePoints?) {
        var counter = 0;
        if let points = points {
            
            if(mode == Mode.None) {
                hideAllViews()
            } else if(mode == Mode.Debug) {
            
                if(counter % 100000 == 0) {
                  print(points.leftEye[0])
                  counter = 0;
                } else {
                    counter = counter + 1;
                }

                for (index, point) in points.leftEye.enumerate() {
                    self.updateViewForFeature("leftEye", index: index, point: point, bgColor: UIColor.blueColor())
                }
                
                for (index, point) in points.rightEye.enumerate() {
                    self.updateViewForFeature("rightEye", index: index, point: point, bgColor: UIColor.blueColor())
                }
                
                for (index, point) in points.leftBrow.enumerate() {
                    self.updateViewForFeature("leftBrow", index: index, point: point, bgColor: UIColor.whiteColor())
                }
                
                for (index, point) in points.rightBrow.enumerate() {
                    self.updateViewForFeature("rightBrow", index: index, point: point, bgColor: UIColor.whiteColor())
                }
                
                for (index, point) in points.nose.enumerate() {
                    self.updateViewForFeature("nose", index: index, point: point, bgColor: UIColor.purpleColor())
                }
                
                for (index, point) in points.outerMouth.enumerate() {
                    self.updateViewForFeature("outerMouth", index: index, point: point, bgColor: UIColor.redColor())
                }
                
                for (index, point) in points.innerMouth.enumerate() {
                    self.updateViewForFeature("innerMouth", index: index, point: point, bgColor: UIColor.yellowColor())
                }
                
            } else if(mode == Mode.Hat) {
                let eyeCornerDist = calculateDistance(points.leftEye[0], pointB: points.rightEye[5])
                let eyeToEyeCenter = calculatePointInBetween(points.leftEye[0], pointB: points.rightEye[5])
                let hatWidth = 2.0 * eyeCornerDist
                let hatHeight = (hatView.image!.size.height / hatView.image!.size.width) * hatWidth
                hatView.transform = CGAffineTransformIdentity
                hatView.frame = CGRectMake(eyeToEyeCenter.x - hatWidth / 2, eyeToEyeCenter.y - 1.3 * hatHeight, hatWidth, hatHeight)
                hatView.hidden = false
                setAnchorPoint(CGPointMake(0.5, 1.0), forView: hatView)
                let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
                hatView.transform = CGAffineTransformMakeRotation(angle)
            } else if(mode == Mode.Mask) {
                let maskWidth = calculateDistance(points.leftEye[0], pointB: points.rightEye[5]) * 1.5
                let noseCenter = CGPointMake(points.nose[3].x, points.nose[3].y)
                let maskHeight = (maskView.image!.size.height / maskView.image!.size.width) * maskWidth
                maskView.transform = CGAffineTransformIdentity
                maskView.frame = CGRectMake(noseCenter.x - maskWidth / 2 + 15, noseCenter.y - maskHeight / 2 - 75, maskWidth, maskHeight)
                maskView.hidden = false
                setAnchorPoint(CGPointMake(0.0, 0.0), forView: maskView)
                let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
                maskView.transform = CGAffineTransformMakeRotation(angle)
            } else if(mode == Mode.Eyes) {
                //left eye
                let leftEyeWidth = calculateDistance(points.leftEye[0], pointB: points.rightEye[5]) * 0.6
                let leftEyeHeight = (leftEyeView.image!.size.height / leftEyeView.image!.size.width) * leftEyeWidth
                leftEyeView.transform = CGAffineTransformIdentity
                leftEyeView.frame = CGRectMake(points.leftEye[0].x - leftEyeWidth / 2 + 45, points.leftEye[0].y - leftEyeHeight / 2, leftEyeWidth, leftEyeHeight)
                leftEyeView.hidden = false
                setAnchorPoint(CGPointMake(0.5, 1.0), forView: leftEyeView)
                let angle = atan2(points.rightEye[5].y - points.leftEye[0].y, points.rightEye[5].x - points.leftEye[0].x)
                leftEyeView.transform = CGAffineTransformMakeRotation(angle)
                
                //right eye
                let rightEyeWidth = calculateDistance(points.leftEye[0], pointB: points.rightEye[5]) * 0.6
                let rightEyeHeight = (rightEyeView.image!.size.height / rightEyeView.image!.size.width) * rightEyeWidth
                rightEyeView.transform = CGAffineTransformIdentity
                rightEyeView.frame = CGRectMake(points.rightEye[5].x - rightEyeWidth + 45, points.rightEye[5].y - rightEyeHeight / 2, rightEyeWidth, rightEyeHeight)
                rightEyeView.hidden = false
                setAnchorPoint(CGPointMake(0.5, 1.0), forView: rightEyeView)
                rightEyeView.transform = CGAffineTransformMakeRotation(angle)
            } else if(mode == Mode.Nose) {
                let noseWidth = calculateDistance(points.nose[0], pointB: points.nose[6]) * 1.6
                let noseHeight = noseWidth
                noseView.transform = CGAffineTransformIdentity
                noseView.frame = CGRectMake(points.nose[3].x - noseWidth / 2 + 10, points.nose[3].y - noseHeight / 2 - 50, noseWidth, noseHeight)
                noseView.hidden = false
                setAnchorPoint(CGPointMake(0.5, 1.0), forView: noseView)
            } else if(mode == Mode.Mouth) {
                let mouthWidth = calculateDistance(points.outerMouth[0], pointB: points.outerMouth[6]) * 1.2
                let mouthHeight = mouthWidth
                mouthView.transform = CGAffineTransformIdentity
                mouthView.frame = CGRectMake(points.innerMouth[2].x - mouthWidth / 2 + 10, points.innerMouth[2].y - mouthHeight / 2 + 40, mouthWidth, mouthHeight)
                mouthView.hidden = false
                setAnchorPoint(CGPointMake(0.5, 1.0), forView: mouthView)
            }
            
        }
        else {
            hideAllViews()
        }
    }
    
}

