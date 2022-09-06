Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56425AF65E
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 22:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIFUwo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 16:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiIFUwn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 16:52:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC031910AA
        for <linux-integrity@vger.kernel.org>; Tue,  6 Sep 2022 13:52:42 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286KjxfN032643;
        Tue, 6 Sep 2022 20:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=AUeMHkMyi3sYxRsETCiZMUP6jGx4DDtwJ9KdLOz+0us=;
 b=U+g6Ws2mPppUjQO1bFKNbyDz9Nvi8qWtONrgS/KnMNtDeowHVZOQNuYQd0pMHEGUAR3/
 LYNF7dFRgi7geRF/0sreWLCE1EikixHC2kEGVqaCaJuzcwjtwz6JH/QuMwYgrqUI4zRU
 R66ysBh7sGyEt8rQmpkJ9JCDzQUUa+J55V2TSdIDhUvY8SDOXDqNorHtDo+S1D9OGnaL
 OKQCKG7UNME64Ms8zwGG4/QMa9tyQuBLfwnnynHpScSPzUkUoaCnlgEtHfJXHWPBdgGk
 k+fTdUVa7GgYnyltjnPw/wuTAVagkpaPnDbB62NFghWfhHxbaUyuUWyxf8bpWPzuJd5z aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jedhh851n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:52:35 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 286Kk4HK000886;
        Tue, 6 Sep 2022 20:52:34 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jedhh851c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:52:34 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286KpKKF030827;
        Tue, 6 Sep 2022 20:52:34 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 3jbxj9dtee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:52:34 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286KqXOB9110098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 20:52:33 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0A38112062;
        Tue,  6 Sep 2022 20:52:33 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38A59112061;
        Tue,  6 Sep 2022 20:52:33 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.107.58])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 20:52:33 +0000 (GMT)
Message-ID: <0e6159f2153f4143a75550c32bd27690f8562266.camel@linux.ibm.com>
Subject: Re: [PATCH v3] ima: Handle -ESTALE returned by
 ima_filter_rule_match()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     GUO Zihua <guozihua@huawei.com>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com
Date:   Tue, 06 Sep 2022 16:52:32 -0400
In-Reply-To: <20220830122906.44496-1-guozihua@huawei.com>
References: <20220830122906.44496-1-guozihua@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: taDbTVueauqkWlSeazIh69JVXc1kJS9T
X-Proofpoint-ORIG-GUID: KXAFVFMQ55c5MaJRgDh6tVrpJOzokVp9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Scott,

On Tue, 2022-08-30 at 20:29 +0800, GUO Zihua wrote:
> IMA relies on the blocking LSM policy notifier callback to update the
> LSM based IMA policy rules.
> 
> When SELinux update its policies, IMA would be notified and starts
> updating all its lsm rules one-by-one. During this time, -ESTALE would
> be returned by ima_filter_rule_match() if it is called with a LSM rule
> that has not yet been updated. In ima_match_rules(), -ESTALE is not
> handled, and the LSM rule is considered a match, causing extra files
> to be measured by IMA.
> 
> Fix it by actively updating current rule if -ESTALE is returned by
> ima_filter_rule_match().
> 
> Fixes: b16942455193 ("ima: use the lsm policy update notifier")
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> ---
> 
> v3:
>   Update current rule instead of just retrying, as suggested by Mimi
> v2:
>   Fixes message errors pointed out by Mimi
> 
> ---
>  security/integrity/ima/ima_policy.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index a8802b8da946..62a5b6164923 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -616,6 +616,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>  			else
>  				return false;
>  		}
> +
> +retry:
>  		switch (i) {
>  		case LSM_OBJ_USER:
>  		case LSM_OBJ_ROLE:
> @@ -635,6 +637,12 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>  		default:
>  			break;
>  		}
> +
> +		if (rc == -ESTALE) {
> +			rc = ima_lsm_update_rule(rule);

This makes a copy of the rule, updates the LSM info, and then replaces
the original rule with the new rule.  Is it really safe to update the
rule like this?  The alternative would be to use a temporary rule with
the updated info.

Mimi
 

> +				goto retry;
> +		}
>  		if (!rc)
>  			return false;
>  	}


