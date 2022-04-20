Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21D850905F
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 21:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381783AbiDTT0s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 15:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381785AbiDTT0r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 15:26:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B40A3DA46
        for <linux-integrity@vger.kernel.org>; Wed, 20 Apr 2022 12:23:52 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KIVSNR008020;
        Wed, 20 Apr 2022 19:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=eFfV/jSfUYDItgzBRrGUCCi9dTXpkblOrqrdOhSfRBs=;
 b=OY14gGK+Ydc0FUo2xGQ+qOMxGhrXOCWBKRH6Y/+K0N5tAZWOoZdcs19bbzlc4FXENyJM
 hTIWGZlw45o51zJkUe5jt0cFCpjuTvA3+fuaMXIHzh5oxH++Lv1ttQn703dKkHknR15x
 RGSJfRRtFAvW4eHPXHrA3lvZ1xvpWVmAiF4uBm7rNYCnVJlSX/6iuNB7bUG/K+nmG9yW
 jghPWU5lV7bAchvcAe+Tr1Pa+2oKa034xmFulx+mFZwe4MQRkMRLBffS9WDx3tQyCV5A
 0LA+9E7SNlweeUckwMQm/eYVV/0HO5gIsF+et+FmR0iP1MMEYKWcVk7doahAhV7h/yYU /g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7kbheqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 19:23:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KJDLDf012437;
        Wed, 20 Apr 2022 19:23:48 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3ffne8prqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 19:23:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KJNjL642992030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 19:23:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71229A4040;
        Wed, 20 Apr 2022 19:23:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D653DA4055;
        Wed, 20 Apr 2022 19:23:44 +0000 (GMT)
Received: from sig-9-65-70-186.ibm.com (unknown [9.65.70.186])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 19:23:44 +0000 (GMT)
Message-ID: <caac73351355243bb1a545fe46ecb88db2600030.camel@linux.ibm.com>
Subject: Re: [PATCH v35 05/29] IMA: avoid label collisions with stacked LSMs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Wed, 20 Apr 2022 15:23:44 -0400
In-Reply-To: <286ba5a2-7399-b2b9-9846-e4235171db32@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
         <20220418145945.38797-6-casey@schaufler-ca.com>
         <286ba5a2-7399-b2b9-9846-e4235171db32@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8xmskws5Mv1ic-U4ONityPcbIRNPP2PW
X-Proofpoint-GUID: 8xmskws5Mv1ic-U4ONityPcbIRNPP2PW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_05,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Casey,

Below are a few initial comments/questions from a high level...

On Tue, 2022-04-19 at 09:50 -0700, Casey Schaufler wrote:
> On 4/18/2022 7:59 AM, Casey Schaufler wrote:

> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index eea6e92500b8..97470354c8ae 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -89,6 +89,7 @@ struct ima_rule_entry {
> >   	bool (*fgroup_op)(kgid_t cred_gid, kgid_t rule_gid); /* gid_eq(), gid_gt(), gid_lt() */
> >   	int pcr;
> >   	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
> > +	int which;		/* which LSM rule applies to */

If "which" was defined in the lsm[] structure, it would be clear
reading the code that "which" refers to an LSM (e.g. entry-
>lsm[i].which).  Perhaps rename "which" to "which_lsm", "lsm_slot", or
"rules_lsm".

> >   	struct {
> >   		void *rule;	/* LSM file metadata specific */
> >   		char *args_p;	/* audit value */
> > @@ -285,6 +286,20 @@ static int __init default_appraise_policy_setup(char *str)
> >   }
> >   __setup("ima_appraise_tcb", default_appraise_policy_setup);
> >   
> > +static int ima_rules_lsm __ro_after_init;
> > +
> > +static int __init ima_rules_lsm_init(char *str)
> > +{
> > +	ima_rules_lsm = lsm_name_to_slot(str);
> > +	if (ima_rules_lsm < 0) {
> > +		ima_rules_lsm = 0;
> > +		pr_err("rule lsm \"%s\" not registered", str);
> > +	}

Specific IMA policy rules could be independent of the default one being
initialized here.  Probably "ima_rules_lsm" should be renamed
"default_rules_lsm" or "default_ima_rules_lsm".  The pr_err() message
should indicate setting the default rule LSM failed with an indication
of which LSM is set as the default.

Assuming 0 is guaranteed to be a valid LSM, then something like: 
 "default rule lsm \"%s\" not registered, using \"%s"\", str,
lsm_slot_to_name(0));

> > +
> > +	return 1;
> > +}
> > +__setup("ima_rules_lsm=", ima_rules_lsm_init);
> > +
> >   static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
> >   {
> >   	struct ima_rule_opt_list *opt_list;
> > @@ -356,7 +371,7 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
> >   	int i;
> >   
> >   	for (i = 0; i < MAX_LSM_RULES; i++) {
> > -		ima_filter_rule_free(entry->lsm[i].rule);
> > +		ima_filter_rule_free(entry->lsm[i].rule, entry->which);
> >   		kfree(entry->lsm[i].args_p);
> >   	}
> >   }

ima_rules_lsm is initialized to 0,  If it isn't guranteed to be a valid
LSM, then ima_rules_lsm_init() needs to be called from ima_init.c:
ima_init(), so that it can be reset to an invalid value.  Then
ima_filter_rule_init()/free() could check it.

thanks,

Mimi

