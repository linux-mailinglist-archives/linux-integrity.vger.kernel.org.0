Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F54F49C06E
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 02:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiAZBH0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 20:07:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231271AbiAZBH0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 20:07:26 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q0kWQ0022126;
        Wed, 26 Jan 2022 01:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0k0U2k0GvmTQA2XH2n5PsousZYs3X1CgOzv1zpirLXc=;
 b=K/cC5b5RLCy6XVpvJoRUZPsa0s58w3XC/kClmDFMJUQyFgPDcGfhpUD2f77kLRDZjEpY
 nn7mdMeNtgHHltPzTZi6BAr7UrYpzUu4oFPj8rFzeKl08DRkMwvP9duTWOYm3KfZvGN5
 v6nvTO2/nofe1Gk9oKvK2zoRYRkD+Epr+PYwbkIVnoOOQOs9rZH24bfte9bd6NXdEVJ2
 WZZXb1JazoeF+eqRB9EmXePl6Wq6C/hz/e6Gss0kN0WrKB+T/H7Wv8EQ7wMeHgkXk/Jt
 wfySM3jHCLNphHX2zFMWj+2fabVjHiu/3HVjkobyv2d6IKHt62ViAiP1kB9TjG0/b20m JA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtv2909xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 01:07:20 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20Q13OjF029506;
        Wed, 26 Jan 2022 01:07:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3dr96jh1we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 01:07:18 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20Q17Glx46203142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 01:07:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA81852050;
        Wed, 26 Jan 2022 01:07:15 +0000 (GMT)
Received: from sig-9-65-78-94.ibm.com (unknown [9.65.78.94])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EC7395204F;
        Wed, 26 Jan 2022 01:07:14 +0000 (GMT)
Message-ID: <36b6058f2cdf6bead917c06ecc6e8769bb88130c.camel@linux.ibm.com>
Subject: Re: [RESEND][PATCH] Documentation: added order requirement for
 ima_hash=
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     GUO Zihua <guozihua@huawei.com>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        roberto.sassu@huawei.com, wangweiyang2@huawei.com,
        xiujianfeng@huawei.com, linux-integrity@vger.kernel.org
Date:   Tue, 25 Jan 2022 20:07:14 -0500
In-Reply-To: <20220125090237.120357-1-guozihua@huawei.com>
References: <20220125090237.120357-1-guozihua@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WFp26E4AN_vMeslmnpvPUd3yo07K1GDJ
X-Proofpoint-ORIG-GUID: WFp26E4AN_vMeslmnpvPUd3yo07K1GDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_06,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201260002
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-01-25 at 17:02 +0800, GUO Zihua wrote:
> From: Guo Zihua <guozihua@huawei.com>
> 
> Commandline parameter ima_hash= and ima_template= has order requirement
> for them to work correctly together. Namely ima_hash= must be
> specified after ima_template=, otherwise ima_template= will be ignored.
> 
> The reason is that when handling ima_hash=, ima template would be set to
> the default value if it has not been initialized already, and that value
> cannot be changed afterwards by ima_template=.
> 
> This patch adds this limitation to the documentation.
> 
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Guo Zihua <guozihua@huawei.com>

This issue should be limited to the original "ima" template format,
which only supports hash algorithms of 20 bytes or less.  The "ima_ng"
template has been the default since larger digests and templates were
upstreamed back in Linux 3.13[1]. Do you really still have kernels
built with the original "ima" template?

[1] Refer to commit 4286587dccd4 ("ima: add Kconfig default measurement
list template").

thanks,

Mimi

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f5a27f067db9..1b5aa6ca65f8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1843,6 +1843,10 @@
>  			The list of supported hash algorithms is defined
>  			in crypto/hash_info.h.
>  
> +			This parameter must be specified after ima_template=,
> +			as it would set the default template and that cannot be
> +			changed by ima_template= afterwards.
> +
>  	ima_policy=	[IMA]
>  			The builtin policies to load during IMA setup.
>  			Format: "tcb | appraise_tcb | secure_boot |
> @@ -1879,6 +1883,9 @@
>  			Formats: { "ima" | "ima-ng" | "ima-sig" }
>  			Default: "ima-ng"
>  
> +			This parameter must be specified before ima_hash=.
> +			Please refer to ima_hash= for further explanation.
> +
>  	ima_template_fmt=
>  			[IMA] Define a custom template format.
>  			Format: { "field1|...|fieldN" }


