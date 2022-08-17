Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410D6597670
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Aug 2022 21:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbiHQT1C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Aug 2022 15:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiHQT1B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Aug 2022 15:27:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF677E03B;
        Wed, 17 Aug 2022 12:27:00 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HJFheV007975;
        Wed, 17 Aug 2022 19:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=iV3nYpGHcei62QgfxkLyP6lWUPtB29bAvycIYroAhHg=;
 b=KqpaSvfARdcghtTGQuscyDmhThohcU7onVZZ1vADvxUoM7J7afkupPHfB+n2mFfUU8wj
 SkJrwkfdyp3aTxJGU73xCyEItwqfQXlz0r8f671caFLqwJqTlBU03epWFw0i0uZcR8CY
 MkZVVmmR92LAR39ivogBj6lBz4AQAmuxMSzipneMrkihfeL4qGHwojbuoN/ti33dQf7K
 w6Q+1uaZl+Pj2Qtacp1NJUahEIzYt7KK4d+gHmkjyt5mitbNsj4V+E1vHfyEqYm1QYLH
 PudTv7SAP9ojQzvuwywqfX+qa687ESBkMaYc6De+B71JC9jnnGRPcqaf0Dkk4szKYXJp Sw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j16b6r96t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 19:26:54 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27HJKp4N009867;
        Wed, 17 Aug 2022 19:26:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3hx3k8un69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 19:26:51 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27HJR7wp35062268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 19:27:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09D064203F;
        Wed, 17 Aug 2022 19:26:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6AFC42041;
        Wed, 17 Aug 2022 19:26:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.49.180])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Aug 2022 19:26:46 +0000 (GMT)
Message-ID: <1309f1ee6fafe75f9f25b2d936171c0c0d2a5fd1.camel@linux.ibm.com>
Subject: Re: Race conditioned discovered between ima_match_rules and
 ima_update_lsm_update_rules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        selinux@vger.kernel.org,
        "xiujianfeng@huawei.com" <xiujianfeng@huawei.com>,
        luhuaxin <luhuaxin1@huawei.com>
Date:   Wed, 17 Aug 2022 15:26:45 -0400
In-Reply-To: <283a9142-f9e5-24b9-808c-f980343acaa7@huawei.com>
References: <ffbb5ff1-cec7-3dad-7330-31fdfb67fecc@huawei.com>
         <cc760579-36f4-fe32-3526-bb647efd438c@huawei.com>
         <CAHC9VhRCt9UKih_VzawKr9dL5oZ7fgOoiU5edLp3hGZ2LkhAYw@mail.gmail.com>
         <649f9797ae80907aa72a8c0418a71df9eacdd1f5.camel@linux.ibm.com>
         <CAHC9VhTO2YDF8paeYfPDj2aAdiNGCDxziHTY2Sa_5C=yup+P_w@mail.gmail.com>
         <c9e269ce-74aa-f2f0-f21d-0d023db23739@huawei.com>
         <283a9142-f9e5-24b9-808c-f980343acaa7@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xZXyTLIJzavly8pdAi6vx6vzglQiSmf2
X-Proofpoint-ORIG-GUID: xZXyTLIJzavly8pdAi6vx6vzglQiSmf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_13,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-08-17 at 15:20 +0800, Guozihua (Scott) wrote:
> On 2022/8/17 15:17, Guozihua (Scott) wrote:
> > On 2022/8/16 6:23, Paul Moore wrote:
> >> On Sun, Aug 14, 2022 at 2:30 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>
> >>> Hi Scott, Paul,
> >>>
> >>> On Tue, 2022-08-09 at 12:24 -0400, Paul Moore wrote:
> >>>> On Sun, Aug 7, 2022 at 11:19 PM Guozihua (Scott) 
> >>>> <guozihua@huawei.com> wrote:
> >>>>>
> >>>>> On 2022/8/8 11:02, Guozihua (Scott) wrote:
> >>>>>> Hi Community,
> >>>>>>
> >>>>>> Recently we discovered a race condition while updating SELinux policy
> >>>>>> with IMA lsm rule enabled. Which would lead to extra files being 
> >>>>>> measured.
> >>>>>>
> >>>>>> While SELinux policy is updated, the IDs for object types and such 
> >>>>>> would
> >>>>>> be changed, and ima_lsm_update_rules would be called.
> >>>>>>
> >>>>>> There are no lock applied in ima_lsm_update_rules. If user accesses a
> >>>>>> file during this time, ima_match_rules will be matching rules 
> >>>>>> based on
> >>>>>> old SELinux au_seqno resulting in selinux_audit_rule_match returning
> >>>>>> -ESTALE.
> >>>>>>
> >>>>>> However, in ima_match_rules, this error number is not handled, 
> >>>>>> causing
> >>>>>> IMA to think the LSM rule is also a match, leading to measuring extra
> >>>>>> files.
> >>>>
> >>>> ...
> >>>>
> >>>>>> Is this the intended behavior? Or is it a good idea to add a lock for
> >>>>>> LSM rules during update?
> >>>>
> >>>> I'm not the IMA expert here, but a lot of effort has been into the
> >>>> SELinux code to enable lockless/RCU SELinux policy access and I
> >>>> *really* don't want to have to backtrack on that.
> >>>
> >>> IMA initially updated it's reference to the SELinux label ids lazily.
> >>> More recently IMA refreshes the LSM label ids based on
> >>> register_blocking_lsm_notifier().  As a result of commit 9ad6e9cb39c6
> >>> ("selinux: fix race between old and new sidtab"), -ESTALE is now being
> >>> returned.
> >>
> >> To be clear, are you seeing this only started happening after commit
> >> 9ad6e9cb39c6?  If that is the case, I would suggest a retry loop
> >> around ima_filter_rule_match() when -ESTALE is returned.  I believe
> >> that should resolve the problem, if not please let us know.
> > 
> > Hi Mimi and Paul
> > 
> > It seems that selinux_audit_rule_match has been returning -ESTALE for a 
> > very long time. It dates back to 376bd9cb357ec.
> > 
> > IMA used to have a retry mechanism, but it was removed by b16942455193 
> > ("ima: use the lsm policy update notifier"). Maybe we should consider 
> > bring it back or just add a lock in ima_lsm_update_rules().
> > 
> > FYI, once ima received the notification, it starts updating all it's lsm 
> > rules one-by-one. During this time, calling ima_match_rules on any rule 
> > that is not yet updated would return -ESTALE.
> 
> I mean a retry might still be needed in ima_match_rules(), but not the 
> ima_lsm_update_rules().

Ok.  So eventually the LSM label ids are properly updated.  Did adding
a retry loop around ima_filter_rule_match(), as Paul suggested, resolve
the problem?

thanks,

Mimi

