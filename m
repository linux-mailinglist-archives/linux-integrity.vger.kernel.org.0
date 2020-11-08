Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03842AABFB
	for <lists+linux-integrity@lfdr.de>; Sun,  8 Nov 2020 16:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgKHPq5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 8 Nov 2020 10:46:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbgKHPq5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Nov 2020 10:46:57 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A8FWAa6195693;
        Sun, 8 Nov 2020 10:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ibB56PShBB5Nq4VNYFUFOEjhgrrjwg3AXBFWoWdlAlc=;
 b=FXEvi7lCKXIY0sJTjNZPsxnSGbHgtXfOIAc82HnpGi1YotauDMukyZHtgrv6hTiRa1fv
 M26y5YiClqMWrPZzGaquJNtpwkn6TUqQy8S66ZjMYUj6HRSGN5tLzehfVuYfPPqJbNqf
 2+JN4XVRZuht6kUE5vwrey2x3AVtf0tqDzs0/XQ+4fk3K96bOaTWksTi8sqN1PJ8mGNH
 FAgqoLl7oMHazREHIrhekjoJQ2jTkMf4xL/0WuLHlpRmm5JuCnfJBq8Tl0qNTA+Tt19H
 Sv4t/Mn4Lp10ORotv1CYko1mXjqTIOjzdhjq2npu75uEzhyRPX7K/WX6Op932s6MsnXt JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34p9kc945r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 08 Nov 2020 10:46:49 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A8Fcop6017260;
        Sun, 8 Nov 2020 10:46:49 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34p9kc945e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 08 Nov 2020 10:46:49 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A8FRdEA002374;
        Sun, 8 Nov 2020 15:46:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 34njuh0kex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 08 Nov 2020 15:46:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A8Fkivm5308996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 8 Nov 2020 15:46:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97CC742045;
        Sun,  8 Nov 2020 15:46:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 539424203F;
        Sun,  8 Nov 2020 15:46:41 +0000 (GMT)
Received: from sig-9-65-237-19.ibm.com (unknown [9.65.237.19])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  8 Nov 2020 15:46:41 +0000 (GMT)
Message-ID: <c2c6efe8b2903949fb7118b56991988ba9c4f582.camel@linux.ibm.com>
Subject: Re: [PATCH v5 6/7] IMA: add critical_data to the built-in policy
 rules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Sun, 08 Nov 2020 10:46:39 -0500
In-Reply-To: <d92869b5-7244-e29e-5d30-c0e06cf45be1@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
         <20201101222626.6111-7-tusharsu@linux.microsoft.com>
         <7219f4404bc1bed6eb090b94363c283ec3266a17.camel@linux.ibm.com>
         <cdcd63f7-ce1f-4463-f886-c36832d7a706@linux.microsoft.com>
         <d92869b5-7244-e29e-5d30-c0e06cf45be1@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-08_06:2020-11-05,2020-11-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=3
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011080109
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Fri, 2020-11-06 at 15:51 -0800, Lakshmi Ramasubramanian wrote:
> 
> >>> diff --git a/security/integrity/ima/ima_policy.c 
> >>> b/security/integrity/ima/ima_policy.c
> >>> index ec99e0bb6c6f..dc8fe969d3fe 100644
> >>> --- a/security/integrity/ima/ima_policy.c
> >>> +++ b/security/integrity/ima/ima_policy.c
> >>
> >>> @@ -875,6 +884,29 @@ void __init ima_init_policy(void)
> >>>                 ARRAY_SIZE(default_appraise_rules),
> >>>                 IMA_DEFAULT_POLICY);
> >>> +    if (ima_use_critical_data) {
> >>> +        template = lookup_template_desc("ima-buf");
> >>> +        if (!template) {
> >>> +            ret = -EINVAL;
> >>> +            goto out;
> >>> +        }
> >>> +
> >>> +        ret = template_desc_init_fields(template->fmt,
> >>> +                        &(template->fields),
> >>> +                        &(template->num_fields));
> >>
> >> The default IMA template when measuring buffer data is "ima_buf".   Is
> >> there a reason for allocating and initializing it here and not
> >> deferring it until process_buffer_measurement()?
> >>
> > 
> > You are right - good catch.
> > I will remove the above and validate.
> > 
> 
> process_buffer_measurement() allocates and initializes "ima-buf" 
> template only when the parameter "func" is NONE. Currently, only 
> ima_check_blacklist() passes NONE for func when calling 
> process_buffer_measurement().
> 
> If "func" is anything other than NONE, ima_match_policy() picks
> the default IMA template if the IMA policy rule does not specify a template.
> 
> We need to add "ima-buf" in the built-in policy for critical_data so 
> that the default template is not used for buffer measurement.
> 
> Please let me know if I am missing something.
> 

Let's explain a bit further what is happening and why.   As you said
ima_get_action() returns the template format, which may be the default
IMA template or the specific IMA policy rule template format.  This
works properly for both the arch specific and custom policies, but not
for builtin policies, because the policy rules may contain a rule
specific .template field.   When the rules don't contain a rule
specific template field, they default to the IMA default template.  In
the case of builtin policies, the policy rules cannot contain the
.template field.

The default template field for process_buffer_measurement() should
always be "ima-buf", not the default IMA template format.   Let's fix
this prior to this patch.

Probably something like this:
- In addition to initializing the default IMA template, initialize the
"ima-buf" template.  Maybe something similiar to
ima_template_desc_current().
- Set the default in process_buffer_measurement() to "ima-buf", before
calling ima_get_action().
- modify ima_match_policy() so that the default policy isn't reset when
already specified.

thanks,

Mimi


> >>
> >>> +        if (ret)
> >>> +            goto out;
> >>> +
> >>> +        critical_data_rules[0].template = template;
> >>> +        add_rules(critical_data_rules,
> >>> +              ARRAY_SIZE(critical_data_rules),
> >>> +              IMA_DEFAULT_POLICY);
> >>> +    }
> >>> +
> >>> +out:
> >>> +    if (ret)
> >>> +        pr_err("%s failed, result: %d\n", __func__, ret);
> >>> +
> >>>       ima_update_policy_flag();
> >>>   }
> >>
> > 
> 

