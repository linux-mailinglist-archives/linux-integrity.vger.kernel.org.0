Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869C029656A
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Oct 2020 21:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509614AbgJVTjl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Oct 2020 15:39:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2509566AbgJVTjl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Oct 2020 15:39:41 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09MJY3Fv062247;
        Thu, 22 Oct 2020 15:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=LlwsFmdGQkjaick47NuYe/9Bov3cPg2THb26Z/It3IU=;
 b=pxsrxV8GX3W4fINSDMpva8d74pTl5SmTcAVHXF44FyGaBYCuEoLB+r7JoWWBU5p1usOt
 GRwAnzv47IbCUBAN7fz14KYPf3F/56edzhA0ybTZwlG/5ko/zCLp/pNipMh9pwtrZjRy
 /epqScdYH97mlCAqPzdxJrF7x7YSrHRaOqbSQGe4GIdkNk/gfOK5rP7wiu0Yq2NS6m4b
 CwXdmHXy66bGWiu9WrJ2u9kB1oJ7Dqwe84TSTtxXwjDVTZDlNm+VkXoQJuW20BpOxb4S
 NzjQm7Z364kmlc1l9HUCQwCfMWmXcNiaT+rKVSeEBUMR8SxKFcPrn+q1go0n0UFr1Y0V hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ba2gn35y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 15:39:35 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09MJYf92070092;
        Thu, 22 Oct 2020 15:39:34 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ba2gn350-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 15:39:34 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09MJburW018547;
        Thu, 22 Oct 2020 19:39:32 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 347qvhdu03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 19:39:31 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09MJdTpj32899428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 19:39:29 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4FA711C04A;
        Thu, 22 Oct 2020 19:39:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 676EA11C054;
        Thu, 22 Oct 2020 19:39:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.54.44])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Oct 2020 19:39:26 +0000 (GMT)
Message-ID: <45aae09df5c301497efc697c17921e9b2a3c8ae8.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/6] IMA: generalize keyring specific measurement
 constructs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Thu, 22 Oct 2020 15:39:25 -0400
In-Reply-To: <20200923192011.5293-2-tusharsu@linux.microsoft.com>
References: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
         <20200923192011.5293-2-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_13:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220123
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Wed, 2020-09-23 at 12:20 -0700, Tushar Sugandhi wrote:

> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index fe1df373c113..31a772d8a86b 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -451,15 +451,19 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>  }
>  
>  /**
> - * ima_match_keyring - determine whether the keyring matches the measure rule
> - * @rule: a pointer to a rule
> - * @keyring: name of the keyring to match against the measure rule
> + * ima_match_rule_data - determine whether the given func_data matches
> + *			 the measure rule data
> + * @rule: IMA policy rule
> + * @opt_list: rule data to match func_data against
> + * @func_data: data to match against the measure rule data
>   * @cred: a pointer to a credentials structure for user validation
>   *
> - * Returns true if keyring matches one in the rule, false otherwise.
> + * Returns true if func_data matches one in the rule, false otherwise.
>   */
> -static bool ima_match_keyring(struct ima_rule_entry *rule,
> -			      const char *keyring, const struct cred *cred)
> +static bool ima_match_rule_data(struct ima_rule_entry *rule,
> +				const struct ima_rule_opt_list *opt_list,
> +				const char *func_data,
> +				const struct cred *cred)
>  {
>  	bool matched = false;
>  	size_t i;
> @@ -467,14 +471,14 @@ static bool ima_match_keyring(struct ima_rule_entry *rule,
>  	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
>  		return false;
>  
> -	if (!rule->keyrings)
> +	if (!opt_list)
>  		return true;

The opt_list should be based on rule->func.  There shouldn't be a need
to pass it as a variable.

Mimi

>  
> -	if (!keyring)
> +	if (!func_data)
>  		return false;
>  
> -	for (i = 0; i < rule->keyrings->count; i++) {
> -		if (!strcmp(rule->keyrings->items[i], keyring)) {
> +	for (i = 0; i < opt_list->count; i++) {
> +		if (!strcmp(opt_list->items[i], func_data)) {
>  			matched = true;
>  			break;
>  		}

