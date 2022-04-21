Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AA2509555
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Apr 2022 05:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383929AbiDUDZV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 23:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244213AbiDUDZU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 23:25:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3682BE0
        for <linux-integrity@vger.kernel.org>; Wed, 20 Apr 2022 20:22:32 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23L2EHwl025304;
        Thu, 21 Apr 2022 03:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=zBWwLlCMM5f2FrciwI/P3HDPcP6jxETdPGF79OZk93U=;
 b=a53kuUWRbBsnDnv0o4F5ZaoImrDa3H0nnwHsYxOeMg3vkQh0u9gKJRjgqWqk4D+kAbeB
 1oALP3CMUTQAe4ST3xAnV2M6w0KsJi0UHmIwf2wVuA8INF3jDSs48kwq9maLZ6UETTGs
 diXnB6yU+0lwlfcH4lZJgZgccHnHD5THy3NalaXvJcgL0Y8l7rqaYKe5BWokI+8ahfgP
 RnG6dDArlKpUgyPWCFe8yq18Zw3j4X24r2OHzjR6RsPztegzl4HmU+O764+/YrBxLSfM
 X9O8h1c6suhS7OWivYby6qBhrngs8JIv1XfZHhrBcbKPYmPeA7nesbMld9eezQpUb509 Jg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fjf52c92q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 03:22:29 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23L37DQN019318;
        Thu, 21 Apr 2022 03:22:28 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3ffne8wngw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 03:22:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23L3MPns45089130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 03:22:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B6C542041;
        Thu, 21 Apr 2022 03:22:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2B844203F;
        Thu, 21 Apr 2022 03:22:24 +0000 (GMT)
Received: from sig-9-65-64-216.ibm.com (unknown [9.65.64.216])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Apr 2022 03:22:24 +0000 (GMT)
Message-ID: <00b621aab1e78905ebf9c0e22e37654a69b55bc8.camel@linux.ibm.com>
Subject: Re: [PATCH v35 05/29] IMA: avoid label collisions with stacked LSMs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Wed, 20 Apr 2022 23:22:24 -0400
In-Reply-To: <286ba5a2-7399-b2b9-9846-e4235171db32@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
         <20220418145945.38797-6-casey@schaufler-ca.com>
         <286ba5a2-7399-b2b9-9846-e4235171db32@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tu34NZlyaoZpqLTqMl4_48AyvC2EqSyz
X-Proofpoint-ORIG-GUID: tu34NZlyaoZpqLTqMl4_48AyvC2EqSyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_06,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210013
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-04-19 at 09:50 -0700, Casey Schaufler wrote:
> 
> > @@ -1025,7 +1043,7 @@ enum policy_opt {
> >   	Opt_fowner_lt, Opt_fgroup_lt,
> >   	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
> >   	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
> > -	Opt_label, Opt_err
> > +	Opt_lsm, Opt_label, Opt_err
> >   };
> >   
> >   static const match_table_t policy_tokens = {
> > @@ -1073,6 +1091,7 @@ static const match_table_t policy_tokens = {
> >   	{Opt_template, "template=%s"},
> >   	{Opt_keyrings, "keyrings=%s"},
> >   	{Opt_label, "label=%s"},
> > +	{Opt_lsm, "lsm=%s"},
> >   	{Opt_err, NULL}
> >   };

The ordering of "Opt_lsm" and "Opt_label" are reversed here.  They need
to be in sync.  Displaying the policy rules results in "label=selinux",
as opposed to "lsm=selinux".

> > @@ -2158,6 +2195,8 @@ int ima_policy_show(struct seq_file *m, void *v)
> >   		seq_puts(m, "appraise_flag=check_blacklist ");
> >   	if (entry->flags & IMA_PERMIT_DIRECTIO)
> >   		seq_puts(m, "permit_directio ");
> > +	if (entry->which >= 0)
> > +		seq_printf(m, pt(Opt_lsm), lsm_slot_to_name(entry->which));

Please only include the LSM name on those rules which are LSM specific.
I would move this statement to the "for (i = 0; i < MAX_LSM_RULES; i++)
{"  loop.  

None of the builtin policy rules are LSM specific.  To test, add
"ima_policy=tcb" to the boot command line.  Then to view the policy,
 cat /sys/kernel/security/ima/policy.

Also, unless the IMA policy rule explicitly indicated a specific LSM, I
would place the LSM name in parenthesis.

> >   	rcu_read_unlock();
> >   	seq_puts(m, "\n");
> >   	return 0;

thanks,

Mimi

