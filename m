Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD325925FB
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Aug 2022 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiHNSac (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 14 Aug 2022 14:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNSab (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 14 Aug 2022 14:30:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29245E0EB;
        Sun, 14 Aug 2022 11:30:30 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27EHbiAC009940;
        Sun, 14 Aug 2022 18:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KxBUd7pa2nUZRRhQOewbZm2CwhO+HiORytJTT6QWhVA=;
 b=E7KwKf9K6Lghzex7ZtLlxNWBkkNssziLcu0Cf9zz77q1TTvIQ/GpNpuV1Zeo+dobPUUM
 6rW8OIqLBAfGi/+hD5demaiL0AK5sGUQGSxvfFLmxWUFLa0nEak2UI6bOcDqpujQo4Mr
 xJdY6QSWers6UGzj8TO/RflvGtshi38Zt+QNptFYI+hmJQ5sbUdXcy9ECmddweepZEYX
 Dqj0wo7SKscGLNMzILW1ZJu1jAMmju52+lVjDeiA4OzBS5VBt1QTjK0yIJ6r5bbiFhk5
 01/Qtl8Km7SDvYO0HisLCfho7Hf/c8eTX9GCuuUNqFYbwFOuos/Kuz1/xi2hyItvAKkE aQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hy3jv2yac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Aug 2022 18:30:17 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27EIMvMP030904;
        Sun, 14 Aug 2022 18:30:15 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3hx3k8rxu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Aug 2022 18:30:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27EIUCIm34210238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Aug 2022 18:30:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD7A7A4053;
        Sun, 14 Aug 2022 18:30:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2898AA4040;
        Sun, 14 Aug 2022 18:30:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.84.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 14 Aug 2022 18:30:10 +0000 (GMT)
Message-ID: <649f9797ae80907aa72a8c0418a71df9eacdd1f5.camel@linux.ibm.com>
Subject: Re: Race conditioned discovered between ima_match_rules and
 ima_update_lsm_update_rules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>,
        "Guozihua (Scott)" <guozihua@huawei.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        selinux@vger.kernel.org,
        "xiujianfeng@huawei.com" <xiujianfeng@huawei.com>,
        luhuaxin <luhuaxin1@huawei.com>
Date:   Sun, 14 Aug 2022 14:30:10 -0400
In-Reply-To: <CAHC9VhRCt9UKih_VzawKr9dL5oZ7fgOoiU5edLp3hGZ2LkhAYw@mail.gmail.com>
References: <ffbb5ff1-cec7-3dad-7330-31fdfb67fecc@huawei.com>
         <cc760579-36f4-fe32-3526-bb647efd438c@huawei.com>
         <CAHC9VhRCt9UKih_VzawKr9dL5oZ7fgOoiU5edLp3hGZ2LkhAYw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lRwG9hK_VCa5WNUTO6Rd0y1HRCB3u4_a
X-Proofpoint-GUID: lRwG9hK_VCa5WNUTO6Rd0y1HRCB3u4_a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-14_11,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208140079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Scott, Paul,

On Tue, 2022-08-09 at 12:24 -0400, Paul Moore wrote:
> On Sun, Aug 7, 2022 at 11:19 PM Guozihua (Scott) <guozihua@huawei.com> wrote:
> >
> > On 2022/8/8 11:02, Guozihua (Scott) wrote:
> > > Hi Community,
> > >
> > > Recently we discovered a race condition while updating SELinux policy
> > > with IMA lsm rule enabled. Which would lead to extra files being measured.
> > >
> > > While SELinux policy is updated, the IDs for object types and such would
> > > be changed, and ima_lsm_update_rules would be called.
> > >
> > > There are no lock applied in ima_lsm_update_rules. If user accesses a
> > > file during this time, ima_match_rules will be matching rules based on
> > > old SELinux au_seqno resulting in selinux_audit_rule_match returning
> > > -ESTALE.
> > >
> > > However, in ima_match_rules, this error number is not handled, causing
> > > IMA to think the LSM rule is also a match, leading to measuring extra
> > > files.
> 
> ...
> 
> > > Is this the intended behavior? Or is it a good idea to add a lock for
> > > LSM rules during update?
> 
> I'm not the IMA expert here, but a lot of effort has been into the
> SELinux code to enable lockless/RCU SELinux policy access and I
> *really* don't want to have to backtrack on that.

IMA initially updated it's reference to the SELinux label ids lazily. 
More recently IMA refreshes the LSM label ids based on
register_blocking_lsm_notifier().  As a result of commit 9ad6e9cb39c6
("selinux: fix race between old and new sidtab"), -ESTALE is now being
returned.

- How likely is it if one SELinux label is stale that other labels are
stale as well? 
- Perhaps SELinux is calling the call_blocking_lsm_notifier() too
early.  Or does SELinux need to call the notifier again after
addressing the ESTALE ids?

thanks,

Mimib

