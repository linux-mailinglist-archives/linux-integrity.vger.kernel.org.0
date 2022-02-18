Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000CA4BC0FC
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 21:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbiBRUJA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 15:09:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbiBRUI7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 15:08:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1BC24B2A3;
        Fri, 18 Feb 2022 12:08:39 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IK8DAX001416;
        Fri, 18 Feb 2022 20:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=8WtNdrz4XvVj3I7dCRdDhnQLA9IgoRhPdH7j9n1eVRI=;
 b=J6HT/HzgyOpMoVTreAAeIfag1EGdjiPgFS8PR8sM+UalIc1CpGkdKlTR4d+EgrLJnGgp
 cXXGqUlOPMfUXfNYVG68dAM+0rsLlsmvuhFtX4a7I/2haPs4+M2+/bTo3DFOvx1qvRB4
 VogJHsqQW9xpWkyRhZGFmZ42vRqfxV+c4rJC1UcE3R6nzC0vCi40zPVeFtprcEbW0KWQ
 aY7UajSrf5y1G77ieduZWOCIMYci7Y7eE2IYf1uFISY3P7BWrrrKlLqYoFLTl+pUW/XZ
 UvmmW7LS6SZhn7D0YhEH08W0Almzt5oDCzZ+6PY7QRM03xdlcndCkkJ81w61Nm9+3dz5 PA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eaj2505es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 20:08:21 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21IK8Lgl002212;
        Fri, 18 Feb 2022 20:08:21 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eaj2505ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 20:08:21 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21IK2ZV8017792;
        Fri, 18 Feb 2022 20:04:27 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3e64hasjd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 20:04:26 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21IK4Lvm43844020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 20:04:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BA06A405B;
        Fri, 18 Feb 2022 20:04:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5F75A4054;
        Fri, 18 Feb 2022 20:04:18 +0000 (GMT)
Received: from sig-9-65-86-101.ibm.com (unknown [9.65.86.101])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Feb 2022 20:04:18 +0000 (GMT)
Message-ID: <15ff4fc5b4386e588c4314ad9712b7044c0bb8f8.camel@linux.ibm.com>
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
Date:   Fri, 18 Feb 2022 15:04:18 -0500
In-Reply-To: <55c0c300-3fe4-f610-0b78-adc5593a70a0@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-17-stefanb@linux.ibm.com>
         <ce1fbc8baf5359b698bf4420e602cc3a5a2a1f44.camel@linux.ibm.com>
         <55c0c300-3fe4-f610-0b78-adc5593a70a0@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hDxCtjCREBgQSbGtvqlRR1EAgOitfuid
X-Proofpoint-GUID: 138CzvqWyVFF4yLwO7JbbyZGW1JDnJIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_09,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-02-18 at 14:38 -0500, Stefan Berger wrote:
> On 2/18/22 12:09, Mimi Zohar wrote:
> > On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
> >> Implement ima_free_policy_rules() that is needed when an ima_namespace
> >> is freed.

ima_free_policy_rules() isn't free all the rules, just the custom
policy rules.  I would update the patch description as:

Implement ima_free_policy_rules() to free the custom policy rules, when
...

Otherwise,

Reviewd-by: Mimi Zohar <zohar@linux.ibm.com>

> >>
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >>
> >> ---
> >> v10:
> >>    - Not calling ima_delete_rules() anymore
> >>    - Move access check from ima_delete_rules into very last patch
> >>
> >>   v9:
> >>    - Only reset temp_ima_appraise when using init_ima_ns.
> >> ---
> >>   security/integrity/ima/ima.h        |  1 +
> >>   security/integrity/ima/ima_policy.c | 14 ++++++++++++++
> >>   2 files changed, 15 insertions(+)
> >>
> >> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> >> index aea8fb8d2854..8c757223d549 100644
> >> --- a/security/integrity/ima/ima.h
> >> +++ b/security/integrity/ima/ima.h
> >> @@ -329,6 +329,7 @@ void ima_update_policy_flags(struct ima_namespace *ns);
> >>   ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule);
> >>   void ima_delete_rules(struct ima_namespace *ns);
> >>   int ima_check_policy(struct ima_namespace *ns);
> >> +void ima_free_policy_rules(struct ima_namespace *ns);
> >>   void *ima_policy_start(struct seq_file *m, loff_t *pos);
> >>   void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
> >>   void ima_policy_stop(struct seq_file *m, void *v);
> >> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> >> index 2dcc5a8c585a..fe3dce8fb939 100644
> >> --- a/security/integrity/ima/ima_policy.c
> >> +++ b/security/integrity/ima/ima_policy.c
> >> @@ -1889,6 +1889,20 @@ void ima_delete_rules(struct ima_namespace *ns)
> >>   	}
> >>   }
> >>   
> >> +/**
> >> + * ima_free_policy_rules - free all policy rules
> >> + * @ns: IMA namespace that has the policy
> >> + */
> >> +void ima_free_policy_rules(struct ima_namespace *ns)
> >> +{
> >> +	struct ima_rule_entry *entry, *tmp;
> >> +
> >> +	list_for_each_entry_safe(entry, tmp, &ns->ima_policy_rules, list) {
> >> +		list_del(&entry->list);
> >> +		ima_free_rule(entry);
> >> +	}
> >> +}
> >> +
> > The first time a policy is loaded, the policy rules pivot
> > from ima_default_rules to the custom rules.  When this happens, the
> > architecture specific policy rules are freed.  Here too, if a custom
> > policy isn't already loaded, the architecture specific rules stored as
> > an array need to be freed.  Refer to the comment in
> > ima_update_policy().
> 
> Right. So here's how it's done (before arch_policy_entry was moved into 
> ima_namespace).
> 
>          /*
>           * IMA architecture specific policy rules are specified
>           * as strings and converted to an array of ima_entry_rules
>           * on boot.  After loading a custom policy, free the
>           * architecture specific rules stored as an array.
>           */
>          kfree(arch_policy_entry);
> 
> 
> So, I now added kfree(ns->arch_policy_entry).

Yes, that is fine.

-- 
thanks,

Mimi

