default: docker-run

all: docker-build docker-run

pristine: clean clean-sources fetch-sources docker-build docker-run

docker-build: docker-build-android docker-build-ios
docker-build-android:
	docker build . -t svg-to-android -f Dockerfile.android
docker-build-ios:
	docker build . -t svg-to-ios -f Dockerfile.ios

docker-run: docker-run-android docker-run-ios
docker-run-android:
	docker run --rm -it  -v $$(PWD)/mounts/input:/mounts/input -v $$(PWD)/mounts/output:/mounts/output svg-to-android
docker-run-ios:
	docker run --rm -it  -v $$(PWD)/mounts/input:/mounts/input -v $$(PWD)/mounts/output:/mounts/output svg-to-ios

clean: clean-android clean-ios
clean-android:
	rm -rf mounts/output/android/*
clean-ios:
	rm -rf mounts/output/ios/*

clean-sources:
	rm -rf src/main/java/com/android

fetch-sources: clean-sources
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/PathBuilder.java?format=TEXT'	| base64 --decode > src/main/java/com/android/ide/common/vectordrawable/PathBuilder.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/Svg2Vector.java?format=TEXT'	| base64 --decode > src/main/java/com/android/ide/common/vectordrawable/Svg2Vector.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgGroupNode.java?format=TEXT'	| base64 --decode > src/main/java/com/android/ide/common/vectordrawable/SvgGroupNode.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgLeafNode.java?format=TEXT'	| base64 --decode > src/main/java/com/android/ide/common/vectordrawable/SvgLeafNode.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgNode.java?format=TEXT'		| base64 --decode > src/main/java/com/android/ide/common/vectordrawable/SvgNode.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgTree.java?format=TEXT'		| base64 --decode > src/main/java/com/android/ide/common/vectordrawable/SvgTree.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/VdElement.java?format=TEXT'		| base64 --decode > src/main/java/com/android/ide/common/vectordrawable/VdElement.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/VdGroup.java?format=TEXT'		| base64 --decode > src/main/java/com/android/ide/common/vectordrawable/VdGroup.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/VdNodeRender.java?format=TEXT'	| base64 --decode > src/main/java/com/android/ide/common/vectordrawable/VdNodeRender.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/VdParser.java?format=TEXT'		| base64 --decode > src/main/java/com/android/ide/common/vectordrawable/VdParser.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/VdPath.java?format=TEXT'		| base64 --decode > src/main/java/com/android/ide/common/vectordrawable/VdPath.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/sdk-common/src/main/java/com/android/ide/common/vectordrawable/VdTree.java?format=TEXT'		| base64 --decode > src/main/java/com/android/ide/common/vectordrawable/VdTree.java

	mkdir -p src/main/java/com/android/ide/common/util		&& curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/sdk-common/src/main/java/com/android/ide/common/util/AssetUtil.java?format=TEXT'	| base64 --decode > src/main/java/com/android/ide/common/util/AssetUtil.java
	mkdir -p src/main/java/com/android/ide/common/blame		&& curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/common/src/main/java/com/android/ide/common/blame/SourcePosition.java?format=TEXT'	| base64 --decode > src/main/java/com/android/ide/common/blame/SourcePosition.java
	mkdir -p src/main/java/com/android						&& curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/common/src/main/java/com/android/SdkConstants.java?format=TEXT'						| base64 --decode > src/main/java/com/android/SdkConstants.java
	mkdir -p src/main/java/com/android/utils				&& curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/common/src/main/java/com/android/utils/PositionXmlParser.java?format=TEXT'			| base64 --decode > src/main/java/com/android/utils/PositionXmlParser.java
	mkdir -p src/main/java/com/android/utils				&& curl --silent 'https://android.googlesource.com/platform/tools/base/+/master/common/src/main/java/com/android/utils/XmlUtils.java?format=TEXT'					| base64 --decode > src/main/java/com/android/utils/XmlUtils.java

	mkdir -p src/main/java/com/android/annotations/concurrency	&& curl --silent 'https://android.googlesource.com/platform/tools/base/+/0c58ef3a3a25e7eb4813825899f2758e035039a5/common/src/main/java/com/android/annotations/concurrency/Immutable.java?format=TEXT'	| base64 --decode > src/main/java/com/android/annotations/concurrency/Immutable.java
	mkdir -p src/com/android/annotations						&& curl --silent 'https://android.googlesource.com/platform/sdk/+/820265d/common/src/com/android/annotations/Nullable.java?format=TEXT'																	| base64 --decode > src/main/java/com/android/annotations/Nullable.java
	mkdir -p src/com/android/annotations						&& curl --silent 'https://android.googlesource.com/platform/sdk/+/820265d/common/src/com/android/annotations/NonNull.java?format=TEXT'																	| base64 --decode > src/main/java/com/android/annotations/NonNull.java
