Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4105D5BD67E
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Sep 2022 23:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiISVhJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Sep 2022 17:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiISVgs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Sep 2022 17:36:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AA14E879;
        Mon, 19 Sep 2022 14:35:51 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JLTAfW035834;
        Mon, 19 Sep 2022 21:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nfdDO4O1fLIIdTg0OTzIcmtf0/5DyeM9daXQo2kkreA=;
 b=Rq0rq5LtsX4ZNbhs4aiv4JXcYEeIWVwkkH69HQ79TcM3XPxnggf0FtaaKnRDf2YKWbBe
 /pfcJNp+4TwpaSxJoa5zu4q9oQJ6c5Y2PVO5M33pYcgz0AkPHHNgLtjo3JbTCqIyBtii
 1ZUkdtaCZrOuxR8uqCl3NRReLKb9h81QGkQXfJxv6KTqFlI5wNSd5U9+M6ExnnnuB4Mm
 iU4kgDGR43/9l0Z2tko6bHy7Tn2fRxZ+8BvNsDVXv7IihkeswHUl5oL0OV6zSV783+3X
 UoN0h8jGeSOmqD6wFFY2OeENU74w+qn28YVX460jVBiP13gOyb/Uy4KJkESjGI6gQV6m bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jq0cn052j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 21:35:35 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28JLVqVS001076;
        Mon, 19 Sep 2022 21:35:35 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jq0cn051n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 21:35:35 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28JLKERe004144;
        Mon, 19 Sep 2022 21:35:34 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01dal.us.ibm.com with ESMTP id 3jn5v9kttd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 21:35:34 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28JLZWkO17629656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 21:35:32 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84A8B5805A;
        Mon, 19 Sep 2022 21:35:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D1615805C;
        Mon, 19 Sep 2022 21:35:32 +0000 (GMT)
Received: from sig-9-77-154-155.ibm.com (unknown [9.77.154.155])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Sep 2022 21:35:31 +0000 (GMT)
Message-ID: <98df3097de3eff15df11cc61985f223b24a52b0b.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] ima: Simplify ima_lsm_copy_rule
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     GUO Zihua <guozihua@huawei.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Mon, 19 Sep 2022 17:35:31 -0400
In-Reply-To: <20220909011516.55957-2-guozihua@huawei.com>
References: <20220909011516.55957-1-guozihua@huawei.com>
         <20220909011516.55957-2-guozihua@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vp5iWTUPECYHkH70VpQXhslaSp0rjnEx
X-Proofpoint-ORIG-GUID: xkkxVaYZyQJxb5dubbc4FdEOW1pPiZwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Scott,

On Fri, 2022-09-09 at 09:15 +0800, GUO Zihua wrote:
> Currently ima_lsm_copy_rule() set the arg_p field of the source rule to
> NULL, so that the source rule could be freed afterward. It does not make
> sense for this behavior to be inside a "copy" function. So move it
> outside and let the caller handle this field.
> 
> As of now, the only user of ima_lsm_copy_rule() is
> ima_lsm_update_rule(). In ima_lsm_update_rule(), we would like to free
> only the lsm.rule in the old rule entry, and leave arg_p untouch. In
> this case, it's better to use ima_filter_rule_free() directly and not
> introduce another for loop to set arg_p to NULL.
> 

This needs to be re-written from a higher perspective.  Perhaps base it
on the existing comment in ima_lsm_update_rule().
 
ima_lsm_copy_rule() shallow copied all references, except for the LSM
references.  Only the LSM references and the entry itself need to be
freed.  Instead of calling ima_lsm_free_rule() to free the LSM
references and also the args_p field, directly free the LSM references.


> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> ---
>  security/integrity/ima/ima_policy.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index a8802b8da946..8040215c0252 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -398,12 +398,6 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  
>  		nentry->lsm[i].type = entry->lsm[i].type;
>  		nentry->lsm[i].args_p = entry->lsm[i].args_p;
> -		/*
> -		 * Remove the reference from entry so that the associated
> -		 * memory will not be freed during a later call to
> -		 * ima_lsm_free_rule(entry).
> -		 */
> -		entry->lsm[i].args_p = NULL;
>  
>  		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
>  				     nentry->lsm[i].args_p,
> @@ -417,6 +411,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  
>  static int ima_lsm_update_rule(struct ima_rule_entry *entry)
>  {
> +	int i;
>  	struct ima_rule_entry *nentry;
>  
>  	nentry = ima_lsm_copy_rule(entry);
> @@ -431,7 +426,8 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
>  	 * references and the entry itself. All other memory references will now
>  	 * be owned by nentry.
>  	 */
> -	ima_lsm_free_rule(entry);
> +	for (i = 0; i < MAX_LSM_RULES; i++)
> +		ima_filter_rule_free(entry->lsm[i].rule);
>  	kfree(entry);
>  
>  	return 0;


