Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDCD68002C
	for <lists+linux-integrity@lfdr.de>; Sun, 29 Jan 2023 17:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjA2QQQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 29 Jan 2023 11:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjA2QQP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 29 Jan 2023 11:16:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941651E5D9;
        Sun, 29 Jan 2023 08:16:00 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30TD0t7Z025302;
        Sun, 29 Jan 2023 16:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=URrOyJCAjBT3JsvzEQ6ZyO6KGrdq8bFCX68xtip+8v8=;
 b=Hd6BN9JlPiaSYAQLcMLePQckWju+3yIpgx6S03F+HaENjJ8Czy8O9sj0C1knTHXMvAKD
 VcDuYKKJgk3XDoSLYD16uqA5m/kPsrTGvPDg1vxwc4rdaNo2QXw9tsGGkNMx6Hhu09Sw
 0Rk+KT6zpxpeqRukLBErDsQ55IgDyiR3kspzCx7anAs6L/pRB0VBRlQ4LvJDIdkLZWuR
 BJfl4Sk3LnfwVLcN+wUFEy+mVpJ0mLLUs+Y6qwBsoVHGZRPgP4XZynwoVe8YInpslswI
 U8T74ZCdBmkYuIEq7+j0PtscYowXH3uSAEsLponfJh43Mj978DtPEzXEzQHPeyx3IPCk 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ndd5gutda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 16:15:51 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30TG7Hc4026844;
        Sun, 29 Jan 2023 16:15:51 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ndd5gutd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 16:15:51 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30TEljO8008390;
        Sun, 29 Jan 2023 16:15:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ncvw288ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 16:15:49 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30TGFmot5964390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 16:15:49 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 987525804E;
        Sun, 29 Jan 2023 16:15:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8BBB5803F;
        Sun, 29 Jan 2023 16:15:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.14.97])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 29 Jan 2023 16:15:47 +0000 (GMT)
Message-ID: <a7f1324e88023a86c3489d53268bde17069ece1f.camel@linux.ibm.com>
Subject: Re: [PATCH -next] evm: call dump_security_xattr() in all cases to
 remove code duplication
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 29 Jan 2023 11:15:47 -0500
In-Reply-To: <20230129004637.191106-1-xiujianfeng@huawei.com>
References: <20230129004637.191106-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 798lgcHa5bewfYNkGljzN29QR9Oi4EUB
X-Proofpoint-ORIG-GUID: RNAGRCTZ2osP1NXI-54T_NxPGGio80yo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=761 priorityscore=1501 clxscore=1015 suspectscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301290158
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> @@ -254,15 +264,9 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>  			if (is_ima)
>  				ima_present = true;
>  
> -			if (req_xattr_value_len < 64)
> -				pr_debug("%s: (%zu) [%*phN]\n", req_xattr_name,
> -					 req_xattr_value_len,
> -					 (int)req_xattr_value_len,
> -					 req_xattr_value);
> -			else
> -				dump_security_xattr(req_xattr_name,
> -						    req_xattr_value,
> -						    req_xattr_value_len);
> +			dump_security_xattr(req_xattr_name,
> +					    req_xattr_value,
> +					    req_xattr_value_len);
>  			continue;
>  		}
>  		size = vfs_getxattr_alloc(&nop_mnt_idmap, dentry, xattr->name,

Hm, this patch doesn't apply properly.

Mimi


