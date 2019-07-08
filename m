Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC519622FE
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 17:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389658AbfGHPbK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 11:31:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389651AbfGHPbJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 11:31:09 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68FRmFI070360
        for <linux-integrity@vger.kernel.org>; Mon, 8 Jul 2019 11:31:08 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tm5rm7dv8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 08 Jul 2019 11:31:07 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 8 Jul 2019 16:31:05 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Jul 2019 16:31:02 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x68FV1HD59900086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jul 2019 15:31:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CAB852050;
        Mon,  8 Jul 2019 15:31:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.58])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A945952051;
        Mon,  8 Jul 2019 15:31:00 +0000 (GMT)
Subject: Re: [PATCH v1 0/5] ima-evm-utils: Assorted fixes and improvements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Petr Vorel <pvorel@suse.cz>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
Date:   Mon, 08 Jul 2019 11:30:50 -0400
In-Reply-To: <20190707234837.4866-1-vt@altlinux.org>
References: <20190707234837.4866-1-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070815-0012-0000-0000-000003305BAB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070815-0013-0000-0000-00002169BD88
Message-Id: <1562599850.11461.43.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080193
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Roberto, Petr, Thiago, Prakhar]

Hi Vitaly,

On Mon, 2019-07-08 at 02:48 +0300, Vitaly Chikunov wrote:
> There is small fixes and improvements to ima-evm-utils.
> Tested on x86_64.
> 
> Vitaly Chikunov (5):
>   ima-evm-utils: Fix EVP_MD_CTX leak in ima_calc_hash
>   ima-evm-utils: Fix memory leak in init_public_keys
>   ima-evm-utils: Preload public keys for ima_verify
>   ima-evm-utils: Allow multiple files in ima_verify
>   ima-evm-utils: Fix clang warning about possible unaligned pointer for
>     hdr->keyid
> 
>  src/evmctl.c    | 11 ++++++++---
>  src/libimaevm.c | 38 ++++++++++++++++++++++++++------------
>  2 files changed, 34 insertions(+), 15 deletions(-)

Thanks, this patch set looks good.  These patches, the "ima-evm-utils: 
Convert v2 signatures from RSA to EVP_PKEY AP", and the two patches I
posted today are now in #next, but I'd really appreciate some
additional Review's/Tested's on these patches.

Now that we're including ALL the kernel exported hash_info algorithms,
a colleague suggested defining a list of deprecated hash algorithms.
 Instead of preventing the usage of these deprecated hash algorithms,
initially I would start out with a warning.  It would be helpful to
indicate which standard deprecated the hash algorithm and year.  At
some point, we might want to prevent their usage in signing files, but
not verifying file signatures.

evmctl "ima_measurement" doesn't support custom template definitions.
Also missing is support for verifying the "ima-buf" kexec command boot
command line and the "ima-modsig" template appended signature.

David Jacobson started writing a regression framework and posted a v2
version.  I'd really appreciate help with cleaning up that code. 

Any other comments/suggestions/ideas?

thanks,

Mimi

