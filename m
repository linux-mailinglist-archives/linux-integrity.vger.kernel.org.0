Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9040C7C451
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Jul 2019 16:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfGaOEX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Jul 2019 10:04:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726300AbfGaOEX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Jul 2019 10:04:23 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VDx280084586
        for <linux-integrity@vger.kernel.org>; Wed, 31 Jul 2019 10:04:22 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u3ahw61cr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 31 Jul 2019 10:04:21 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 31 Jul 2019 15:04:19 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Jul 2019 15:04:18 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6VE4Hlk52232348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 14:04:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27249AE056;
        Wed, 31 Jul 2019 14:04:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D655AE051;
        Wed, 31 Jul 2019 14:04:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.188])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 31 Jul 2019 14:04:16 +0000 (GMT)
Subject: Re: [PATCH v4] ima-evm-utils: Add some tests for evmctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 31 Jul 2019 10:04:05 -0400
In-Reply-To: <20190731052658.12785-1-vt@altlinux.org>
References: <20190731052658.12785-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19073114-4275-0000-0000-000003526B51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073114-4276-0000-0000-000038635B2C
Message-Id: <1564581845.4189.184.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310142
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Wed, 2019-07-31 at 08:26 +0300, Vitaly Chikunov wrote:
> Run `make check' to execute the tests.
> Currently only ima_hash, (evm) sign, (evm) verify, ima_sign, and
> ima_verify are tested.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

I probably haven't applied all of the prereq patches, so some of the
tests are failing.  As a result, I found:

- (Thank you for changing the simple "FOR" variable.)  There are a
couple of "ADD_FOR_TEXT" instead of "ADD_TEXT_FOR".

> +
> +# Test if xattr $attr in $file matches $pref'ix
> +# Show error and fail otherwise.
> +_test_xattr() {
> +  local file=$1 attr=$2 pref=$3
> +  local test_for=${ADD_TEXT_FOR:+ for $ADD_TEXT_FOR}
> +
> +  if ! getfattr -n $attr -e hex $file | egrep -qx "$attr=$pref"; then
> +    red_if_failure
> +    echo "Did not find expected hash$text_for:"

^test_for

> +    echo "    $attr=$pref"
> +    echo ""
> +    echo "Actual output below:"
> +    getfattr -n $attr -e hex $file | sed 's/^/    /'
> +    color_restore
> +    rm $file
> +    ADD_TEXT_FOR=
> +    return $FAIL
> +  fi
> +  ADD_TEXT_FOR=
> +}

Mimi

