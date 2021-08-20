Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95053F300A
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 17:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbhHTPtc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 11:49:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238154AbhHTPt0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 11:49:26 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KFjZCN043590;
        Fri, 20 Aug 2021 11:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xh6LWvHeAWbhM97e0iww23h6bQHh4+p3ykTROU1TwM4=;
 b=qdIbQp0EiMoVv2wqrG+UPLFHGR/xUfBW1LDBdJjrgvs7miwX3BvFTJW747s+Osyj5bC0
 p9reGZs/g1dkUZ0WT6ItU7WDwwfYMMda61SF5S+vwscIQ0mq/Nzc7CutRncpQcdRNjt6
 WqefQFYgFHAfXqAbl2yxyZSNFAgSa1iZ8a+a+4/ls+h6mtFLCvw2MbEB0zHRF+wpLbgC
 4aBs6/Kfs7RNm6YPGYCgNdPprUvy8EYGu6iKeDKvkE1saBVZF9tw1TI2PH+SEc51lbQ0
 vPXaG59VZc8unl/P4x+1Pv2mXSGRmDsW+n5TB1jXO5OuRFpjF8Kbe2x4cLwqTywOSzJd ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ajdykaed7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 11:48:34 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17KFjiqJ044671;
        Fri, 20 Aug 2021 11:48:33 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ajdykaecq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 11:48:33 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17KFktHJ007334;
        Fri, 20 Aug 2021 15:48:31 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3ae5f8gr3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 15:48:30 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17KFmSv057016684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 15:48:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CA6442042;
        Fri, 20 Aug 2021 15:48:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 882E74203F;
        Fri, 20 Aug 2021 15:48:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.35.235])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Aug 2021 15:48:26 +0000 (GMT)
Message-ID: <96037695de6125c701889c168550def278adfd4b.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: fix infinite loop within "ima_match_policy"
 function.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        =?UTF-8?Q?=E6=9D=8E=E5=8A=9B=E7=90=BC?= <liqiong@nfschina.com>
Cc:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 20 Aug 2021 11:48:25 -0400
In-Reply-To: <1f631c3d-5dce-e477-bfb3-05aa38836442@viveris.fr>
References: <20210819101529.28001-1-liqiong@nfschina.com>
         <8d17f252-4a93-f430-3f25-e75556ab01e8@viveris.fr>
         <d385686b-ffa5-5794-2cf2-b87f2a471e78@nfschina.com>
         <1f631c3d-5dce-e477-bfb3-05aa38836442@viveris.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yqk0ER5Tsk2AVXIU7Vs5OeebCbgT7VzI
X-Proofpoint-ORIG-GUID: -pwQdXdaNs2K8TBDf6RmAmnFvP35-2F1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-20_06:2021-08-20,2021-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200087
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-08-20 at 13:23 +0000, THOBY Simon wrote:
> Hi Liqiong,
> 
> On 8/20/21 12:15 PM, 李力琼 wrote:
> > Hi, Simon:
> > 
> > This solution is better then rwsem, a temp "ima_rules" variable should 
> > can fix. I also have a another idea, with a little trick, default list
> > can traverse to the new list, so we don't need care about the read side. 
> > 
> > here is the patch:
> > 
> > @@ -918,8 +918,21 @@ void ima_update_policy(void)
> >         list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
> > 
> >         if (ima_rules != policy) {
> > +               struct list_head *prev_rules = ima_rules;
> > +               struct list_head *first = ima_rules->next;
> >                 ima_policy_flag = 0;
> > +
> > +               /*
> > +                * Make the previous list can traverse to new list,
> > +                * that is tricky, or there is a deadly loop whithin
> > +                * "list_for_each_entry_rcu(entry, ima_rules, list)"
> > +                *
> > +                * After update "ima_rules", restore the previous list.
> > +                */
> 
> I think this could be rephrased to be a tad clearer, I am not quite sure
> how I must interpret the first sentence of the comment.
> 
> 
> > +               prev_rules->next = policy->next;
> >                 ima_rules = policy;
> > +               syncchronize_rcu();
> 
> I'm a bit puzzled as you seem to imply in the mail this patch was tested,
> but there is no 'syncchronize_rcu' (with two 'c') symbol in the kernel.
> Was that a copy/paste error? Or maybe you forgot the 'not' in "This
> patch has been tested"? These errors happen, and I am myself quite an
> expert in doing them :)
> 
> > +               prev_rules->next = first;
> > 
> > 
> > The side effect is the "ima_default_rules" will be changed a little while.
> > But it make sense, the process should be checked again by the new policy.
> > 
> > This patch has been tested, if will do, I can resubmit this patch.> 
> > How about this ?
> 
> 
> Correct me if I'm wrong, here is how I think I understand you patch.
> We start with a situation like that (step 0):
> ima_rules --> List entry 0 (head node) = ima_default_rules <-> List entry 1 <-> List entry 2 <-> ... <-> List entry 0
> 
> Then we decide to update the policy for the first time, so
> 'ima_rules [&ima_default_rules] != policy [&ima_policy_rules]'.
> We enter the condition.
> First we copy the current value of ima_rules (&ima_default_rules)
> to a temporary variable 'prev_rules'. We also create a pointer dubbed
> 'first' to the entry 1 in the default list (step 1):
> prev_rules -------------
>                        \/
> ima_rules --> List entry 0 (head node) = ima_default_rules <-> List entry 1 <-> List entry 2 <-> ... <-> List entry 0
>                                                                    /\
> first --------------------------------------------------------------
> 
> 
> Then we update prev_rules->next to point to policy->next (step 2):
> List entry 1 <-> List entry 2 <-> ... -> List entry 0
>  /\
> first
> 	(notice that list entry 0 no longer points backwards to 'list entry 1',
> 	but I don't think there is any reverse iteration in IMA, so it should be
> 	safe)
> 
> prev_rules -------------
>                        \/
> ima_rules --> List entry 0 (head node) = ima_default_rules   
>                        |
>                        |
>                        -------------------------------------------
>                                                                  \/
> policy --> policy entry 0' (head node) = ima_policy_rules <-> policy entry 1' <-> policy entry 2' <-> .... <-> policy entry 0'
> 
> 
> We then update ima_rules to point to ima_policy_rules (step 3):
> List entry 1 <-> List entry 2 <-> ... -> List entry 0
>  /\
> first
> 
> prev_rules -------------
>                        \/
> ima_rules     List entry 0 (head node) = ima_default_rules   
>      |                 |
>      |                 |
>      |                 ------------------------------------------
>      ---------------                                            |
>                    \/                                           \/
> policy --> policy entry 0' (head node) = ima_policy_rules <-> policy entry 1' <-> policy entry 2' <-> .... <-> policy entry 0'
>                                                                    /\
> first --------------------------------------------------------------
> 
> Then we run synchronize_rcu() to wait for any RCU reader to exit their loops (step 4).
> 
> Finally we update prev_rules->next to point back to the ima policy and fix the loop (step 5):
> 
> List entry 1 <-> List entry 2 <-> ... -> List entry 0
>  /\
> first
> 
> prev_rules ---> List entry 0 (head node) = ima_default_rules <-> List entry 1 <-> List entry 2 <-> ... <-> List entry 0
>                                                                      /\
>                                                                  first (now useless)
> ima_rules        
>      |
>      |
>      |
>      ---------------
>                    \/
> policy --> policy entry 0' (head node) = ima_policy_rules <-> policy entry 1' <-> policy entry 2' <-> .... <-> policy entry 0'
> 
> The goal is that readers should still be able to loop
> (forward, as we saw that backward looping is temporarily broken)
> while in steps 0-4.
> 
> I'm not completely sure what would happen to a client that started iterating
> over ima_rules right after step 2.
> 
> Wouldn't they be able to start looping through the new policy
> as 'List entry 0 (head node) = ima_default_rules' points to ima_policy_rules?
> And if they, wouldn't they loop until the write to 'ima_rule' at step 3 (admittedly
> very shortly thereafter) completed?
> And would the compiler be allowed to optimize the read to 'ima_rules' in the
> list_for_each_entry() loop, thereby never reloading the new value for
> 'ima_rules', and thus looping forever, just what we are trying to avoid?
> 
> Overall, I'm tempted to say this is perhaps a bit too complex (at least,
> my head tells me it is, but that may very well be because I'm terrible
> at concurrency issues).
> 
> Honestly, in this case I think awaiting input from more experienced
> kernel devs than I is the best path forward :-)

I'm far from an expert on RCU locking, but __list_splice_init_rcu()
provides an example of how to make sure there aren't any readers
traversing the list, before two lists are spliced together.   In our
case, after there aren't any readers, instead of splicing two lists
together, it should be safe to point to the new list.

thanks,

Mimi

