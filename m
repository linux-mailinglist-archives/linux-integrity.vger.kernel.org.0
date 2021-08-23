Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7B93F4A23
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 13:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhHWL7D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 07:59:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230289AbhHWL7C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 07:59:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NBer9d074737;
        Mon, 23 Aug 2021 07:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Iz5i4ZAicf4aU0DCS+OudBoa8Tt/wnm5/hH+U4ImtW8=;
 b=kAIhI5nRg3uksu4gcZcAHZB1OS1dr+Qnyn/t9NOYguEqYNkleQwAtAgj0qOi7QLqrLJx
 5oFIQy1lse+aaCp5M7AE9wAVWbfp0wS3NaA8Zq07UoNKysp/7rv/+lDYYFCozSMEcLaT
 qb6FPF0RLGs8RNbq2sxPi3m1YEIwXG6ELUHu3KUxbUt+NFfu2rqLclGqAP4hcJMamlJ4
 N4EkqE7M2/IC8M1952TdSEtvBcx1ilrbdPoa+0HueOp7Z4kVTqVebUhky3SpVI7e5obi
 SSqfQtqKInwuRjJDDfEZuN1O9dQCb/f4fF54KR4zuRO0NlAhCrshy8dBBezSsKPbv9Sa 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aketbn23w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 07:58:07 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17NBg3d5080512;
        Mon, 23 Aug 2021 07:58:06 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aketbn236-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 07:58:06 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NBlRqS001122;
        Mon, 23 Aug 2021 11:58:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3ajs48jsf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 11:58:04 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NBsNUx19726674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 11:54:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB53E42064;
        Mon, 23 Aug 2021 11:58:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D1B442066;
        Mon, 23 Aug 2021 11:57:59 +0000 (GMT)
Received: from sig-9-65-215-209.ibm.com (unknown [9.65.215.209])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Aug 2021 11:57:59 +0000 (GMT)
Message-ID: <c02ff60205fdb343cb5a2ff0e4384fc7b47635a3.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: fix infinite loop within "ima_match_policy"
 function.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        liqiong <liqiong@nfschina.com>
Cc:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 23 Aug 2021 07:57:58 -0400
In-Reply-To: <cf715a40-b255-c688-578c-7f8bcd004ee3@viveris.fr>
References: <20210819101529.28001-1-liqiong@nfschina.com>
         <8d17f252-4a93-f430-3f25-e75556ab01e8@viveris.fr>
         <d385686b-ffa5-5794-2cf2-b87f2a471e78@nfschina.com>
         <1f631c3d-5dce-e477-bfb3-05aa38836442@viveris.fr>
         <96037695de6125c701889c168550def278adfd4b.camel@linux.ibm.com>
         <f9798484-7090-0ddf-50a6-7c7c5bf0606c@nfschina.com>
         <fee498ec-087c-b52d-102c-d29d98f9b794@nfschina.com>
         <cf715a40-b255-c688-578c-7f8bcd004ee3@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9QsYbkk7545Yp63gPbE_sSc7eneAplqW
X-Proofpoint-ORIG-GUID: bPmOxHmBGqHxFt7c_9c3SXKk4WMHQExu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_02:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230078
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-08-23 at 08:14 +0000, THOBY Simon wrote:
> Hi Liqiong,
> 
> On 8/23/21 10:06 AM, liqiong wrote:
> > Hi Simon :
> > 
> > Using a temporary ima_rules variable is not working for "ima_policy_next". 
> > 
> >  void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
> >  {
> >  	struct ima_rule_entry *entry = v;
> > -
> > +	struct list_head *ima_rules_tmp = rcu_dereference(ima_rules);
> >  	rcu_read_lock();
> >  	entry = list_entry_rcu(entry->list.next, struct ima_rule_entry, list);
> >  	rcu_read_unlock();
> >  	(*pos)++;
> >  
> > -	return (&entry->list == ima_rules) ? NULL : entry;
> > +	return (&entry->list == ima_rules_tmp) ? NULL : entry;
> >  }
> > 
> > It seems no way to fix "ima_rules" change within this function, it will alway
> > return a entry if "ima_rules" being changed.
> 
> - I think rcu_dereference() should be called inside the RCU read lock
> - Maybe we could cheat with:
> 	return (&entry->list == &ima_policy_rules || &entry->list == &ima_default_rules) ? NULL : entry;
>   as that's the only two rulesets IMA ever use?
>   Admittedly, this is not as clean as previously, but it should work too.
> 
> The way I see it, the semaphore solution would not work here either,
> as ima_policy_next() is called repeatedly as a seq_file
> (it is set up in ima_fs.c) and we can't control the locking there:
> we cannot lock across the seq_read() call (that cure could end up be
> worse than the disease, deadlock-wise), so I fear we cannot protect
> against a list update while a user is iterating with a lock.
> 
> So in both cases a cheat like "&entry->list == &ima_policy_rules || &entry->list == &ima_default_rules"
> maybe need to be considered.
> 
> What do you think?

Is this an overall suggestion or limited to just ima_policy_next()?

thanks,

Mimi


