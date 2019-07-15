Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B56769B24
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 21:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfGOTJC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 15:09:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbfGOTJC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 15:09:02 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FJ6caa113898
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jul 2019 15:09:01 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2trwds5jf8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jul 2019 15:09:01 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 15 Jul 2019 20:08:59 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Jul 2019 20:08:56 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6FJ8uiE21823878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 19:08:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E74D052051;
        Mon, 15 Jul 2019 19:08:55 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 77AEB52050;
        Mon, 15 Jul 2019 19:08:55 +0000 (GMT)
Subject: Re: [PATCH v1 2/5] ima-evm-utils: Fix possible strcpy overflow
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 15 Jul 2019 15:08:55 -0400
In-Reply-To: <20190712212833.29280-2-vt@altlinux.org>
References: <20190712212833.29280-1-vt@altlinux.org>
         <20190712212833.29280-2-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071519-0028-0000-0000-0000038479BE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071519-0029-0000-0000-0000244498C1
Message-Id: <1563217735.4539.145.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=904 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907150218
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-07-13 at 00:28 +0300, Vitaly Chikunov wrote:
> caps_str is passed from command line but copied into fixed-size buffer.
> CID 229895.
> ---
>  src/evmctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 39bc3d9..e07cff4 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -409,8 +409,9 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
>  		} else if (!strcmp(*xattrname, XATTR_NAME_CAPS) && (hmac_flags & HMAC_FLAG_CAPS_SET)) {
>  			if (!caps_str)
>  				continue;
> -			strcpy(xattr_value, caps_str);
>  			err = strlen(caps_str);
> +			assert(err < sizeof(xattr_value));

"calc_evm_hash" can be called while walking and labeling, or
verifying, a file system.  We probably don't want to abruptly end it.
 Maybe emit an error message and return and error?


> +			strcpy(xattr_value, caps_str);
>  		} else {
>  			err = lgetxattr(file, *xattrname, xattr_value, sizeof(xattr_value));
>  			if (err < 0) {

