Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21FB680D67
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jan 2023 13:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjA3MR5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Jan 2023 07:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbjA3MR4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jan 2023 07:17:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7265DB466;
        Mon, 30 Jan 2023 04:17:55 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UB7kVt003506;
        Mon, 30 Jan 2023 12:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=i40+gziWh7C/2x/dRRV+Ofcoa07nssiNjMbPCIBuiJE=;
 b=TWDzGWDLPxWaBZoekTlpcfQ6FkamvCdQXTO63lQr2ZsAxORkvJ4ZZLH8uVjPODEgUzfH
 OBo8wFuMCUlXKFU/C+uHjnlf5ZOOsb9Gs7UM6Od+UMMTGrlXrEu3siiunfzowG0BQXG5
 fgeF45hJFW6Al2mnzAwEbpRZWXYcwXTa3SXMw5HLZEPMXnGYu4ILlU+q4foGcB7uxbnJ
 AGtsCaCrboYIPLFVtot8BJx28Crmvy0Crp6htx35Ykpfvy3tGqqLJG8ywdqCketCaKGX
 QmXusuy3DD05mTEXgIEWB11HwP7S2A5VgGQEbZXa6q2p4XfAbtIsju9Ctn6spLMz7CO1 lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3neb2mc45m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 12:17:38 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30UBifjs009455;
        Mon, 30 Jan 2023 12:17:38 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3neb2mc457-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 12:17:38 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30UBv5G6026845;
        Mon, 30 Jan 2023 12:17:37 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3ncvtmtka8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 12:17:37 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UCHaft49545480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 12:17:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A404058054;
        Mon, 30 Jan 2023 12:17:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A274C5803F;
        Mon, 30 Jan 2023 12:17:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.4.127])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 12:17:35 +0000 (GMT)
Message-ID: <9c6826bb7e5aa85be06865f5a2bed0e30b4ad33e.camel@linux.ibm.com>
Subject: Re: [PATCH -next] evm: call dump_security_xattr() in all cases to
 remove code duplication
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     xiujianfeng <xiujianfeng@huawei.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Christian Brauner b <brauner@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 30 Jan 2023 07:17:35 -0500
In-Reply-To: <c95487db-f304-2610-5e93-41d7b39934d7@huawei.com>
References: <20230129004637.191106-1-xiujianfeng@huawei.com>
         <a7f1324e88023a86c3489d53268bde17069ece1f.camel@linux.ibm.com>
         <c95487db-f304-2610-5e93-41d7b39934d7@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yyQPi3eyiELmEbrlE5M183Hj_t8fKXwr
X-Proofpoint-ORIG-GUID: aCyXdoosdXqLZfAvXRvgPPdb4596M_YN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_10,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1011 spamscore=0 mlxlogscore=981 priorityscore=1501 adultscore=0
 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc: Christian Brauner <brauner@kernel.org>]

On Mon, 2023-01-30 at 12:02 +0800, xiujianfeng wrote:
> Hi,
> 
> On 2023/1/30 0:15, Mimi Zohar wrote:
> >> @@ -254,15 +264,9 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
> >>  			if (is_ima)
> >>  				ima_present = true;
> >>  
> >> -			if (req_xattr_value_len < 64)
> >> -				pr_debug("%s: (%zu) [%*phN]\n", req_xattr_name,
> >> -					 req_xattr_value_len,
> >> -					 (int)req_xattr_value_len,
> >> -					 req_xattr_value);
> >> -			else
> >> -				dump_security_xattr(req_xattr_name,
> >> -						    req_xattr_value,
> >> -						    req_xattr_value_len);
> >> +			dump_security_xattr(req_xattr_name,
> >> +					    req_xattr_value,
> >> +					    req_xattr_value_len);
> >>  			continue;
> >>  		}
> >>  		size = vfs_getxattr_alloc(&nop_mnt_idmap, dentry, xattr->name,
> > 
> > Hm, this patch doesn't apply properly.
> 
> I noticed that the patch fails to apply on linux master, however this
> patch is meant for linux-next, would you please maybe have a look?

I wasn't aware of the change.  However, merge conflicts should not be
"fixed", but mentioned immediately after the patch break line ("---") .
FYI, this merge conflict is a result of commit 4609e1f18e19 ("fs: port
->permission() to pass mnt_idmap").

Patches for the linux-integrity branch should be based on the next-
integrity branch.
-- 
thanks,

Mimi

