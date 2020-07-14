enum NyaaItemType { NORMAL, TRUSTED, REMAKE, BATCH }

NyaaItemType getNyaaItemType(String type) {
  if (type.contains('success'))
    return NyaaItemType.TRUSTED;
  else if (type.contains('danger'))
    return NyaaItemType.REMAKE;
  else if (type.contains('warning'))
    return NyaaItemType.BATCH;
  else
    return NyaaItemType.NORMAL;
}
