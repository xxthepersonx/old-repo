%hook _UIScreenEdgePanRecognizerEdgeSettings

-(void)setEdgeRegionSize:(double)arg1 {

%orig(0);

}

-(double)edgeRegionSize {

return 0;

}


%end
