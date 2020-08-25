Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEC5252218
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Aug 2020 22:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHYUoH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Aug 2020 16:44:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726627AbgHYUoG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Aug 2020 16:44:06 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PKWEj9143603;
        Tue, 25 Aug 2020 16:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=qq9xo8OEuC+VNL592BWu6lVgpZVzSQUt/espQc/7n+A=;
 b=ULlc7yStgzIc5WXanqAqDaPQ8c8j2d58czY2G2ZKTQ343iorNtYqvQwPv2I63YqHhTEg
 IwaXeuf+/NcHhqH+cvXFmUWOapmfL1v0mgFUfyxRaxi0K9smx8n0eaJ3/2bd8H48ryNe
 o1A1vnV51SdHfgJsgShLcgkY3PFxn05emjX5oBwQKYhPvk6KCValbxTdjnpIdA3eY7wa
 TQjRWG9f2iMjz15YbCloxhWfxjboI1R/jbu4Ffg98tdSMllSLfDWc/5B3jUPFXHgTMiH
 tuqu+HGAc47ARvATsEpmUqawn3IA55vnoU/x2IfVmJAsub5raXO4sgylSf2e7Bs3mCY7 zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3356116nyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 16:44:00 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07PKWIxg143749;
        Tue, 25 Aug 2020 16:44:00 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3356116nx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 16:44:00 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07PKcqO4004186;
        Tue, 25 Aug 2020 20:43:57 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 332ujrtat5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 20:43:57 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07PKht9623986526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 20:43:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A210A4051;
        Tue, 25 Aug 2020 20:43:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9038A404D;
        Tue, 25 Aug 2020 20:43:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.103.4])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Aug 2020 20:43:51 +0000 (GMT)
Message-ID: <879a504a63021b248e8d2ce952283bbf83f21688.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] IMA: add policy to support measuring critical
 data from kernel components
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Tue, 25 Aug 2020 16:43:50 -0400
In-Reply-To: <e701ad15-1672-d208-c2b8-8228a728c98d@linux.microsoft.com>
References: <20200821182107.5328-1-tusharsu@linux.microsoft.com>
         <20200821182107.5328-3-tusharsu@linux.microsoft.com>
         <d82c5cdab170d3dcc513b38632801c3aa14ca389.camel@linux.ibm.com>
         <e701ad15-1672-d208-c2b8-8228a728c98d@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_09:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250150
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-08-25 at 10:32 -0700, Tushar Sugandhi wrote:
> 
> On 2020-08-24 3:46 p.m., Mimi Zohar wrote:
> > On Fri, 2020-08-21 at 11:21 -0700, Tushar Sugandhi wrote:
> > > There would be several candidate kernel components suitable for IMA
> > > measurement. Not all of them would have support for IMA measurement.
> > > Also, system administrators may not want to measure data for all of
> > > them, even when they support IMA measurement. An IMA policy specific
> > > to various kernel components is needed to measure their respective
> > > critical data.
> > > 
> > > Add a new IMA policy CRITICAL_DATA+data_sources to support measuring
> > > various critical kernel components. This policy would enable the
> > > system administrators to limit the measurement to the components,
> > > if the components support IMA measurement.
> > > 
> > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > ---
> > >   Documentation/ABI/testing/ima_policy |  6 ++-
> > >   security/integrity/ima/ima.h         |  1 +
> > >   security/integrity/ima/ima_api.c     |  2 +-
> > >   security/integrity/ima/ima_policy.c  | 62 +++++++++++++++++++++++++---
> > >   4 files changed, 63 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> > > index cd572912c593..a0dd0f108555 100644
> > > --- a/Documentation/ABI/testing/ima_policy
> > > +++ b/Documentation/ABI/testing/ima_policy
> > > @@ -29,7 +29,7 @@ Description:
> > >   		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
> > >   				[FIRMWARE_CHECK]
> > >   				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> > > -				[KEXEC_CMDLINE] [KEY_CHECK]
> > > +				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
> > >   			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
> > >   			       [[^]MAY_EXEC]
> > >   			fsmagic:= hex value
> > > @@ -125,3 +125,7 @@ Description:
> > >   		keys added to .builtin_trusted_keys or .ima keyring:
> > >   
> > >   			measure func=KEY_CHECK keyrings=.builtin_trusted_keys|.ima
> > > +
> > > +		Example of measure rule using CRITICAL_DATA to measure critical data
> > > +
> > > +			measure func=CRITICAL_DATA data_sources=selinux|apparmor|dm-crypt
> > 
> > This example uses "data_sources" without first defining it in the
> > "option:" section.  Defining two new options is an indication that this
> Thanks. I will define "data_sources" first in "option:" section.
> > patch should be split up.  One which defines the "CRITICAL_DATA" and
> > another one which defines the new key value pair.  The term
> I intentionally kept the "CRITICAL_DATA" and "data_sources" in the same
> patch.
> 
> CRITICAL_DATA is different than KEY_CHECK because in case of KEY_CHECK,
> "keyrings=" is optional. If "keyrings=" is not specified, then we
> measure all keyrings.
> 
> Where for CRITICAL_DATA, "data_sources=" is mandatory.
> 
> Because the data sources would be diverse and orthogonal to each other,
> (unlike "keyrings=") - not specifying "data_sources=" shouldn't result
> in IMA blindly measuring all data sources.

Good point.
> 
> Since CRITICAL_DATA, and "data_sources=" go hand in hand, I wanted them
> to be part of the same patch.

Separating them will help clarify the patch description.  There's no
harm in defining the critical data source first.

> > "data_sources" is pretty generic.  Perhaps constrain it a bit by re-
> > naming it "critical_data=".  Or was such using a generic name
> > intentional?
> > 
> We intentionally kept the name generic because the data to be measured
> could be coming from any kernel component with any granularity (from a
> single bool to megabytes of data). The kernel component is also loosely
> defined here. It could be an LSM (like SELinux), or a broader base layer
> (like device-mapper), or a specific module (like dm-crypt), or it could
> be different parts of a single module.
> 
> Also, we didn't want to name "data_sources" as "critical_data" to avoid
> confusion with func "CRITICAL_DATA".

The point is that you're measuring critical data, not just any data
from any source.  Whatever term is used, it needs to be added to the
Documentation/ABI/testing/ima_policy.  I think something that is self
describing will help.  See what makes the most sense.

> > Normally "CRITICAL_DATA" would be defined with the critical data hook,
> > but that seems to be defined in patch 3/3 "IMA: define IMA hook to
> > measure critical data from kernel components".
> > 
> I can make the "CRITICAL_DATA" and the hook as part of the same patch.
> That would mean combining patch 2 and 3 into a single one.
> 
> Does it sound ok?

In the other thread, we discussed separating out "measure_payload_hash"from other changes.  The end result you want one logical change per patch.  Each patch builds upon the previous one.  (Look at how Tyler does it.)

> > > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > > index 8875085db689..0f4209a92bfb 100644
> > > --- a/security/integrity/ima/ima.h
> > > +++ b/security/integrity/ima/ima.h
> > > @@ -200,6 +200,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
> > >   	hook(POLICY_CHECK, policy)			\
> > >   	hook(KEXEC_CMDLINE, kexec_cmdline)		\
> > >   	hook(KEY_CHECK, key)				\
> > > +	hook(CRITICAL_DATA, critical_data)		\
> > >   	hook(MAX_CHECK, none)
> > >   
> > >   #define __ima_hook_enumify(ENUM, str)	ENUM,
> > > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> > > index af218babd198..9917e1730cb6 100644
> > > --- a/security/integrity/ima/ima_api.c
> > > +++ b/security/integrity/ima/ima_api.c
> > > @@ -176,7 +176,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
> > >    *		subj=, obj=, type=, func=, mask=, fsmagic=
> > >    *	subj,obj, and type: are LSM specific.
> > >    *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
> > > - *	| KEXEC_CMDLINE | KEY_CHECK
> > > + *	| KEXEC_CMDLINE | KEY_CHECK | CRITICAL_DATA
> > >    *	mask: contains the permission mask
> > >    *	fsmagic: hex value
> > >    *
> > > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > > index 8866e84d0062..7b649095ac7a 100644
> > > --- a/security/integrity/ima/ima_policy.c
> > > +++ b/security/integrity/ima/ima_policy.c
> > > @@ -33,6 +33,7 @@
> > >   #define IMA_PCR		0x0100
> > >   #define IMA_FSNAME	0x0200
> > >   #define IMA_KEYRINGS	0x0400
> > > +#define IMA_DATA_SOURCES	0x0800
> > >   
> > >   #define UNKNOWN		0
> > >   #define MEASURE		0x0001	/* same as IMA_MEASURE */
> > > @@ -84,6 +85,7 @@ struct ima_rule_entry {
> > >   	} lsm[MAX_LSM_RULES];
> > >   	char *fsname;
> > >   	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
> > > +	struct ima_rule_opt_list *data_sources; /* Measure data from these sources */
> > >   	struct ima_template_desc *template;
> > >   };
> > >   
> > > @@ -508,14 +510,23 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> > >   {
> > >   	int i;
> > >   
> > > -	if (func == KEY_CHECK) {
> > > -		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
> > > -		       ima_match_rule_data(rule, rule->keyrings, func_data,
> > > -					   true, cred);
> > > -	}
> > >   	if ((rule->flags & IMA_FUNC) &&
> > >   	    (rule->func != func && func != POST_SETATTR))
> > >   		return false;
> > > +
> > > +	switch (func) {
> > > +	case KEY_CHECK:
> > > +		return ((rule->func == func) &&
> > > +			ima_match_rule_data(rule, rule->keyrings,
> > > +					    func_data, true, cred));
> > > +	case CRITICAL_DATA:
> > > +		return ((rule->func == func) &&
> > > +			ima_match_rule_data(rule, rule->data_sources,
> > > +					    func_data, false, cred));
> > > +	default:
> > > +		break;
> > > +	}
> > > +
> > >   	if ((rule->flags & IMA_MASK) &&
> > >   	    (rule->mask != mask && func != POST_SETATTR))
> > >   		return false;
> > > @@ -911,7 +922,7 @@ enum {
> > >   	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
> > >   	Opt_appraise_type, Opt_appraise_flag,
> > >   	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
> > > -	Opt_err
> > > +	Opt_data_sources, Opt_err
> > >   };
> > >   
> > >   static const match_table_t policy_tokens = {
> > > @@ -948,6 +959,7 @@ static const match_table_t policy_tokens = {
> > >   	{Opt_pcr, "pcr=%s"},
> > >   	{Opt_template, "template=%s"},
> > >   	{Opt_keyrings, "keyrings=%s"},
> > > +	{Opt_data_sources, "data_sources=%s"},
> > >   	{Opt_err, NULL}
> > >   };
> > >   
> > > @@ -1110,6 +1122,19 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
> > >   		if (ima_rule_contains_lsm_cond(entry))
> > >   			return false;
> > >   
> > > +		break;
> > > +	case CRITICAL_DATA:
> > > +		if (entry->action & ~(MEASURE | DONT_MEASURE))
> > > +			return false;
> > > +
> > > +		if (!(entry->flags & IMA_DATA_SOURCES) ||
> > > +		    (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
> > > +		    IMA_DATA_SOURCES)))
> > > +			return false;
> > 
> > Requiring IMA_FUNC and IMA_DATA_SOURCES makes sense, but why are
> > IMA_UID and IMA_PCR required?
> > 
> Since the data to be measured could be for any scenario, I didn't want
> to restrict the kernel components from choosing UID to measure the data
> for, or restrict them from choosing PCR to store the measurements in.
> But as the consumers are kernel components, perhaps support for IMA_UID
> is not required.  But we should still support IMA_PCR.
> Please let me know what do you think, and I can update the logic
> accordingly.

I think I misinterpreted this code.  As long as IMA_UID and IMA_PCR
aren't required, then it is fine.

> > > +
> > > +		if (ima_rule_contains_lsm_cond(entry))
> > > +			return false;
> > > +
> > >   		break;
> > >   	default:
> > >   		return false;
> > > @@ -1242,6 +1267,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
> > >   			else if (IS_ENABLED(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) &&
> > >   				 strcmp(args[0].from, "KEY_CHECK") == 0)
> > >   				entry->func = KEY_CHECK;
> > > +			else if (strcmp(args[0].from, "CRITICAL_DATA") == 0)
> > > +				entry->func = CRITICAL_DATA;
> > >   			else
> > >   				result = -EINVAL;
> > >   			if (!result)
> > > @@ -1312,6 +1339,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
> > >   
> > >   			entry->flags |= IMA_KEYRINGS;
> > >   			break;
> > > +		case Opt_data_sources:
> > > +			ima_log_string(ab, "data_sources", args[0].from);
> > > +
> > > +			if (entry->data_sources) {
> > > +				result = -EINVAL;
> > > +				break;
> > > +			}
> > > +
> > > +			entry->data_sources = ima_alloc_rule_opt_list(args);
> > > +			if (IS_ERR(entry->data_sources)) {
> > > +				result = PTR_ERR(entry->data_sources);
> > > +				entry->data_sources = NULL;
> > > +				break;
> > > +			}
> > > +
> > 
> > "keyrings=" isn't bounded because keyrings can be created by userspace.
> > Perhaps keyring names has a minimum/maximum length.  IMA isn't
> > measuring userspace construsts.  Shouldn't the list of critical data
> > being measured be bounded and verified?
> The comment is not entirely clear.
> Do you mean there should be some sort of allow_list in IMA, against
> which the values in "data_sources=" should be vetted? And if the
> value is present in the IMA allow_list, then only the measurements for
> that data source are allowed?
> 
> Or do you mean something else?

Yes, something along those lines.  Does the list of critical data need
to be vetted?  And if so, against what?

Mimi

> > 
> > > +			entry->flags |= IMA_DATA_SOURCES;
> > > +			break;
> > >   		case Opt_fsuuid:
> > >   			ima_log_string(ab, "fsuuid", args[0].from);
> > >   
> > > @@ -1692,6 +1736,12 @@ int ima_policy_show(struct seq_file *m, void *v)
> > >   		seq_puts(m, " ");
> > >   	}
> > >   
> > > +	if (entry->flags & IMA_DATA_SOURCES) {
> > > +		seq_puts(m, "data_sources=");
> > > +		ima_show_rule_opt_list(m, entry->data_sources);
> > > +		seq_puts(m, " ");
> > > +	}
> > > +
> > >   	if (entry->flags & IMA_PCR) {
> > >   		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
> > >   		seq_printf(m, pt(Opt_pcr), tbuf);


