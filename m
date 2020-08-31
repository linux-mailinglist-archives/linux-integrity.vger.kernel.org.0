Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126EF2578CF
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Aug 2020 13:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHaL4A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Aug 2020 07:56:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726167AbgHaL4A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Aug 2020 07:56:00 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07VB2tNO140261;
        Mon, 31 Aug 2020 07:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3NqTThVQ8eaoP7oELAZFEv4/SLtWiHWWrwVAhpVkpk8=;
 b=hdX++FVthQmmHIUCRF++GF+br4ETo0E1IXszaV4waSDggNyyW+CblURewKoKVE9+7+wX
 jtlkmTbFSyWezqvgj1dYxn6J7yPOnt2++gvO+ImtTwz2qgou4AO96IEmcHENte+sHzaO
 X+IEjlFggT49gLLpfU1QB7/TusX9uwRJvuDeKEvelBOyH9uo65NusT/Qj/2WBLHhfOgJ
 ExiKBB9JMK+M9+pqm+jk5Dnmbi2CZxPIsgYQxQh3VEn+dOSWbQy8GZ9zChzuTsS7CgHu
 pG9zZRBKwvMmsT78twDDRPkcm0evGR2nUKvPg9nF53vadfKkJtW1uaVfkMWUR2Y+txB+ 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 338xgvbgf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 07:55:54 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07VBPJih031055;
        Mon, 31 Aug 2020 07:55:54 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 338xgvbget-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 07:55:53 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07VBmS5r002148;
        Mon, 31 Aug 2020 11:55:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 337en819qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 11:55:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07VBtnPh26411484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 11:55:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47839A405B;
        Mon, 31 Aug 2020 11:55:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C219A4051;
        Mon, 31 Aug 2020 11:55:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.2.129])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Aug 2020 11:55:45 +0000 (GMT)
Message-ID: <4802c73c2ed22c64ea4f315d3115ead919c3205e.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/6] IMA: generalize keyring specific measurement
 constructs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Mon, 31 Aug 2020 07:55:45 -0400
In-Reply-To: <20200828015704.6629-2-tusharsu@linux.microsoft.com>
References: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
         <20200828015704.6629-2-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-31_04:2020-08-31,2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310062
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-08-27 at 18:56 -0700, Tushar Sugandhi wrote:
> IMA functions such as ima_match_keyring(), process_buffer_measurement(),
> ima_match_policy() etc. handle data specific to keyrings. Currently,
> these constructs are not generic to handle any func specific data.
> This makes it harder to extend without code duplication.
> 
> Refactor the keyring specific measurement constructs to be generic and
> reusable in other measurement scenarios.

Mostly this patch changes the variable name from keyring to func_data,
which is good.  Other changes should be minimized.

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---

<snip>

> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index fe1df373c113..8866e84d0062 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -451,15 +451,21 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
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
> + * @allow_empty_opt_list: If true matches all func_data
>   * @cred: a pointer to a credentials structure for user validation
>   *
> - * Returns true if keyring matches one in the rule, false otherwise.
> + * Returns true if func_data matches one in the rule, false otherwise.
>   */
> -static bool ima_match_keyring(struct ima_rule_entry *rule,
> -			      const char *keyring, const struct cred *cred)
> +static bool ima_match_rule_data(struct ima_rule_entry *rule,
> +				const struct ima_rule_opt_list *opt_list, 

Ok

> +				const char *func_data,
> +				bool allow_empty_opt_list,

As the policy is loaded, shouldn't the rules should be checked, not
here on usage?

Mimi

> +				const struct cred *cred)
>  {
>  	bool matched = false;
>  	size_t i;
> 

