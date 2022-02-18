Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CCA4BBE08
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 18:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiBRRMZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 12:12:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiBRRMZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 12:12:25 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D133D489;
        Fri, 18 Feb 2022 09:12:08 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IH9XD6001484;
        Fri, 18 Feb 2022 17:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=HHQiOYioRcDJxJ+cIF5L0R34uf85m0MBy/ByxExjiM0=;
 b=LJ9gogOogoZ16KMDJH28oSIAHgNyxbxXYDB2tSanM4cvYROk7el7VsTwioKhJEEhR2wv
 bIeZiLHym7AQ7WxXeJDT6zxa3VTZjNH7aXqYREI+mUPyNllrrykuxWVqcflmX9uAeeDw
 xpxwQeL85DWSJ1M005SgavHLwNAqHRO1BkU2zleS7w3tW3NZFfqrB9VsUzr1QkxItGmw
 1iw/VkgOPoF3I64vO86pS1gmlj+shpJS2YCib/Pj0TL159R//3+d0bC38SXE8TgzVB1B
 l5nKKa9QqADN8xJXZoZ9r6dirYZsrE+w60NltufBmznzVQbutVbink2MwWopUl4hjcQ5 Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eae34aqrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 17:09:43 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21IH9huH002074;
        Fri, 18 Feb 2022 17:09:43 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eae34aqqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 17:09:43 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21IH3xwn005118;
        Fri, 18 Feb 2022 17:09:41 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3e64haufhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 17:09:40 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21IGx9eE49742204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 16:59:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE795A405B;
        Fri, 18 Feb 2022 17:09:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62423A4057;
        Fri, 18 Feb 2022 17:09:35 +0000 (GMT)
Received: from sig-9-65-84-246.ibm.com (unknown [9.65.84.246])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Feb 2022 17:09:35 +0000 (GMT)
Message-ID: <ce1fbc8baf5359b698bf4420e602cc3a5a2a1f44.camel@linux.ibm.com>
Subject: Re: [PATCH v10 16/27] ima: Implement ima_free_policy_rules() for
 freeing of an ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Fri, 18 Feb 2022 12:09:34 -0500
In-Reply-To: <20220201203735.164593-17-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-17-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: emIEgItrNC7fS0Qb3QAVkkh-aKJwErjg
X-Proofpoint-GUID: jh3pxOibFXtcr2wDrWDhypmigqOTtxcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_07,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202180109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
> Implement ima_free_policy_rules() that is needed when an ima_namespace
> is freed.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---
> v10:
>   - Not calling ima_delete_rules() anymore
>   - Move access check from ima_delete_rules into very last patch
> 
>  v9:
>   - Only reset temp_ima_appraise when using init_ima_ns.
> ---
>  security/integrity/ima/ima.h        |  1 +
>  security/integrity/ima/ima_policy.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index aea8fb8d2854..8c757223d549 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -329,6 +329,7 @@ void ima_update_policy_flags(struct ima_namespace *ns);
>  ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule);
>  void ima_delete_rules(struct ima_namespace *ns);
>  int ima_check_policy(struct ima_namespace *ns);
> +void ima_free_policy_rules(struct ima_namespace *ns);
>  void *ima_policy_start(struct seq_file *m, loff_t *pos);
>  void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
>  void ima_policy_stop(struct seq_file *m, void *v);
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 2dcc5a8c585a..fe3dce8fb939 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1889,6 +1889,20 @@ void ima_delete_rules(struct ima_namespace *ns)
>  	}
>  }
>  
> +/**
> + * ima_free_policy_rules - free all policy rules
> + * @ns: IMA namespace that has the policy
> + */
> +void ima_free_policy_rules(struct ima_namespace *ns)
> +{
> +	struct ima_rule_entry *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &ns->ima_policy_rules, list) {
> +		list_del(&entry->list);
> +		ima_free_rule(entry);
> +	}
> +}
> +

The first time a policy is loaded, the policy rules pivot
from ima_default_rules to the custom rules.  When this happens, the
architecture specific policy rules are freed.  Here too, if a custom
policy isn't already loaded, the architecture specific rules stored as
an array need to be freed.  Refer to the comment in
ima_update_policy().

>  #define __ima_hook_stringify(func, str)	(#func),
>  
>  const char *const func_tokens[] = {

-- 
thanks,

Mimi


