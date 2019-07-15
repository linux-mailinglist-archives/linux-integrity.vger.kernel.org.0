Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E677F69B22
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 21:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfGOTIZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 15:08:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbfGOTIY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 15:08:24 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FJ8BBu041762
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jul 2019 15:08:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2try8b8bd2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jul 2019 15:08:22 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 15 Jul 2019 20:08:21 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Jul 2019 20:08:18 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6FJ8HK243122792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 19:08:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 790A5AE055;
        Mon, 15 Jul 2019 19:08:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE195AE045;
        Mon, 15 Jul 2019 19:08:16 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Jul 2019 19:08:16 +0000 (GMT)
Subject: Re: [PATCH v1 1/5] ima-evm-utils: Fix null dereference from
 file2bin to memcpy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 15 Jul 2019 15:08:16 -0400
In-Reply-To: <20190712212833.29280-1-vt@altlinux.org>
References: <20190712212833.29280-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071519-0008-0000-0000-000002FD7414
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071519-0009-0000-0000-0000226AE780
Message-Id: <1563217696.4539.144.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907150218
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-07-13 at 00:28 +0300, Vitaly Chikunov wrote:
> file2bin() may return NULL, which is set to tmp, which is passed to
> memcpy. Add explicit check for it. CID 229904.

Maybe move the CID to a "Fixes" tag with an indication of the CID
origin.

> ---
>  src/evmctl.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index a6d07c9..39bc3d9 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -821,7 +821,15 @@ static int verify_ima(const char *file)
>  	if (sigfile) {
>  		void *tmp = file2bin(file, "sig", &len);
> 
> -		assert(len <= sizeof(sig));

Thanks for removing the "assert".  It would stop the measurement list
verification or walking a file system in the middle.

> +		if (!tmp) {
> +			log_err("Failed reading: %s\n", file);
> +			return -1;
> +		}
> +		if (len > sizeof(sig)) {
> +			log_err("File is too big: %s\n", file);

We're reading the file signature file.  Perhaps say,"File signature is
...".

> +			free(tmp);
> +			return -1;
> +		}
>  		memcpy(sig, tmp, len);
>  		free(tmp);
>  	} else {

