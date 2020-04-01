Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2761019B504
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Apr 2020 20:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbgDASBD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Apr 2020 14:01:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730420AbgDASBD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Apr 2020 14:01:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031HYAiP066441
        for <linux-integrity@vger.kernel.org>; Wed, 1 Apr 2020 14:01:02 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304g86mfbq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 01 Apr 2020 14:01:02 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 1 Apr 2020 19:00:58 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 19:00:55 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 031I0uW040436062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 18:00:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93AAE11C052;
        Wed,  1 Apr 2020 18:00:56 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C62A311C069;
        Wed,  1 Apr 2020 18:00:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.185.67])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 18:00:55 +0000 (GMT)
Subject: Re: [PATCH v8 2/2] ima-evm-utils: Add sign/verify tests for evmctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 01 Apr 2020 14:00:55 -0400
In-Reply-To: <20200327042515.22315-3-vt@altlinux.org>
References: <20200327042515.22315-1-vt@altlinux.org>
         <20200327042515.22315-3-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040118-0028-0000-0000-000003F02CE5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040118-0029-0000-0000-000024B5B408
Message-Id: <1585764055.5188.652.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_03:2020-03-31,2020-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010146
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-03-27 at 07:25 +0300, Vitaly Chikunov wrote:

<snip>

> +# Perform sign and verify ima and evm testing
> +sign_verify() {
> +  local key=$1 alg=$2 pref="$3" opts="$4"
> +  local file=$alg.txt
> +
> +  # Set defaults:
> +  # Public key is different for v1 and v2 (where x509 cert is used).
> +  if [[ $opts =~ --rsa ]]; then
> +    KEY=test-$key.pub
> +  else
> +    KEY=test-$key.cer
> +  fi
> +  ALG=$alg
> +  PREF=$pref
> +  OPTS=$opts
> +  FILE=$file
> +
> +  TYPE=ima
> +  if expect_pass check_sign; then
> +
> +    # Normal verify with proper key should pass
> +    expect_pass check_verify
> +
> +    # Multiple files and some don't verify
> +    expect_fail check_verify FILE=/dev/null,$file

The comment and the code don't seem to be in sync.  This seems to be a
single file, for example, named "/dev/null,sha1.txt", which properly
fails.

____ START positive test: check_verify
+ evmctl -vvv ima_verify --key test-rsa1024.pub --xattr-user --rsa
sha1.txt
  hash-v1: da39a3ee5e6b4b0d3255bfef95601890afd80709
  sighash: e34807780b93cc17bdac89573df40ee4a3e984f1
  sha1.txt: verification is OK
^^^^ STOP (0) positive test: check_verify
____ START negative test: check_verify FILE=/dev/null,sha1.txt
- evmctl -vvv ima_verify --key test-rsa1024.pub --xattr-user --rsa
/dev/null,sha1.txt
evmctl ima_verify failed properly with (1)
  getxattr failed: /dev/null,sha1.txt
  errno: No such file or directory (2)
^^^^ STOP (1) negative test: check_verify FILE=/dev/null,sha1.txt

> +  fi
> +
> +  TYPE=evm
> +  # Avoid running blkid for evm tests which may require root
> +  # No generation on overlayfs:
> +  # ioctl(3, FS_IOC_GETVERSION, 0x7ffd8e0bd628) = -1 ENOTTY (Inappropriate ioctl for device)
> +  OPTS="$opts --uuid --generation 0"
> +  if expect_pass check_sign; then
> +
> +    # Normal verify with proper key
> +    expect_pass check_verify
> +
> +    # Verify with wrong key
> +    expect_fail check_verify KEY=rsa2048
> +  fi
> +
> +  # Note: Leaving TYPE=evm and file is evm signed
> +}
> +
> +# Test --keys
> +try_different_keys() {
> +  # This run after sign_verify which leaves
> +  # TYPE=evm and file is evm signed
> +
> +  # v2 signing can work with multiple keys in --key option
> +  if [[ ! $OPTS =~ --rsa ]]; then
> +
> +    # Have correct key in the key list
> +    expect_pass check_verify KEY=test-rsa2048.cer,$KEY
> +    expect_pass check_verify KEY=/dev/null,$KEY,

First test has multiple keys in the key list.  The key list with
"/dev/null" obviously fails to add the first key, so it lands up being
a single key on the list.

> +  fi
> +
> +  # Try key that is not used for signing
> +  expect_fail check_verify KEY=rsa2048
> +
> +  # Try completely wrong key files
> +  expect_fail check_verify KEY=/dev/null
> +  expect_fail check_verify KEY=/dev/zero
> +}
> +
> +try_different_sigs() {
> +  # TYPE=evm and file is evm signed
> +
> +  # Test --imasig
> +  if expect_pass check_sign OPTS="$OPTS --imasig"; then
> +
> +    # Verify both evm and ima sigs
> +    expect_pass check_verify
> +    expect_pass check_verify TYPE=ima
> +  fi
> +
> +  # Test --imahash
> +  if expect_pass check_sign OPTS="$OPTS --imahash"; then
> +
> +    expect_pass check_verify
> +
> +    # IMA hash is not verifiable by ima_verify
> +    expect_fail check_verify TYPE=ima
> +  fi
> +
> +  # Test --portable
> +  expect_pass check_sign OPTS="$OPTS --portable" PREF=0x05
> +  # Cannot be verified

True, evmctl does not support verifying portable signatures, but it
should be possible not only locally, but remotely to verify a portable
signature.  That's the whole point of having portable EVM signatures.
 The comment is a bit misleading and could say something to that
effect - "todo: add support for evmctl portable signature
verification".

Mimi

