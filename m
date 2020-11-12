Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F1D2B10DD
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Nov 2020 23:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgKLWCe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Nov 2020 17:02:34 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55396 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgKLWCd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Nov 2020 17:02:33 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id D983D20C2875;
        Thu, 12 Nov 2020 14:02:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D983D20C2875
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605218552;
        bh=Ui0Z5VOxxbDH95DXw+QwzLwhD9FGbOnNfr2u9UFPUWs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M4vlqCsWFk+Lh0PKybpm0DXA18/IQYNEZP5h+9daCmSuD+MYHjbMKh4IfOE7raUPo
         Fg6YGjEd+U9W5nRvDtDVAlWOgSD3OMXphj1fZOMY8p41hIuK4pyE6mNqRCh8Z+MeCB
         Xr787by8OmFEWD6B9B9pGI8skRaa8rfikhCi62S8=
Subject: Re: [PATCH v5 4/7] IMA: add policy to measure critical data
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
 <20201101222626.6111-5-tusharsu@linux.microsoft.com>
 <6d835878af2f11c837633510775742e57a1506eb.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <85f392a2-7c81-a744-0bd2-ed97fbc7f66e@linux.microsoft.com>
Date:   Thu, 12 Nov 2020 14:02:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6d835878af2f11c837633510775742e57a1506eb.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-11-06 5:43 a.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
>> System administrators should be able to choose which kernel subsystems
>> they want to measure the critical data for. To enable that, an IMA policy
>> option to choose specific kernel subsystems is needed. This policy option
>> would constrain the measurement of the critical data to the given kernel
>> subsystems.
> 
> Measuring critical data should not be dependent on the source of the
> critical data.   This patch needs to be split up.  The "data sources"
> should be move to it's own separate patch.  This patch should be
> limited to adding the policy code needed for measuring criticial data.
> Limiting critical data sources should be the last patch in this series.
> 
> thanks,
> 
> Mimi
> 
Thanks Mimi.

Ok. I will split the patches as you suggested.
Patch #1 (this patch) will have the policy code needed for measuring
critical data.
patch #2 Limiting the critical “data_sources”.

*Question 1*
Since you said patch #2 should be the last patch in this series, do you 
mean merging patch #2 with the SeLinux patch? (patch 7/7 of this series)
Or a separate patch before 7/7?

*Question 2*
If I understand it correctly, the following code should be moved from 
this patch to patch #2. Did I miss anything?

  static const match_table_t policy_tokens = {
@@ -957,6 +971,7 @@ static const match_table_t policy_tokens = {
  	{Opt_pcr, "pcr=%s"},
  	{Opt_template, "template=%s"},
  	{Opt_keyrings, "keyrings=%s"},
+	{Opt_data_sources, "data_sources=%s"},
  	{Opt_err, NULL}
  };


+		case Opt_data_sources:
+			ima_log_string(ab, "data_sources",
+				       args[0].from);
+
+			if (entry->data_sources) {
+				result = -EINVAL;
+				break;
+			}
+
+			entry->data_sources = ima_alloc_rule_opt_list(args);
+			if (IS_ERR(entry->data_sources)) {
+				result = PTR_ERR(entry->data_sources);
+				entry->data_sources = NULL;
+				break;
+			}
+
+			entry->flags |= IMA_DATA_SOURCES;
+			break;

+	if (entry->flags & IMA_DATA_SOURCES) {
+		seq_puts(m, "data_sources=");
+		ima_show_rule_opt_list(m, entry->data_sources);
+		seq_puts(m, " ");
+	}
+

~Tushar

>>
>> Add a new IMA policy option - "data_sources:=" to the IMA func
>> CRITICAL_DATA to allow measurement of various kernel subsystems. This
>> policy option would enable the system administrators to limit the
>> measurement to the subsystems listed in "data_sources:=", if the
>> subsystem measures its data by calling ima_measure_critical_data().
>>
>> Limit the measurement to the subsystems that are specified in the IMA
>> policy - CRITICAL_DATA+"data_sources:=". If "data_sources:=" is not
>> provided with the func CRITICAL_DATA, measure the data from all the
>> supported kernel subsystems.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
