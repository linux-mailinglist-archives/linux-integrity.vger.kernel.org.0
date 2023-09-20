Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196A07A8D2F
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Sep 2023 21:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjITTzn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Sep 2023 15:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITTzm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Sep 2023 15:55:42 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EC9A3
        for <linux-integrity@vger.kernel.org>; Wed, 20 Sep 2023 12:55:36 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KJbdkk009911;
        Wed, 20 Sep 2023 19:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/ZGxzQFpeZRoYINAln3aPSFXlIr0lRgI8XvutM+g18s=;
 b=l5mU56kT5UeESD2itddIjBM92HNn1n7IBxO1iR1nmyNAd3ibxg1g8YpwrGo4SCfB0YMu
 pI6zseAvIUwzaxulxOA9axEoonLZRSEt5A2R04Ddf7IbM0IwQBd/o0Qu8ttiljaBXWF6
 l8qOD+w6Y+Gb79evVCg3CXiCNwOEAAFhwOVN5yJqHz+PkakEFH/VcYomFjAvNVTUmIXD
 JXUO1rmzif+m3jliwiTib6GTPcBtC9Lg+XdeWA/+I4Jr4VdEEljWxuojjFAkxhKHYinG
 YrYVRvm7+3vLagKqQxs3TOWIx6omGZEjF2ABa+uMi/4fF15gKveXMa7L0xyVEr7mOHWC 5w== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t81v8tawh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:55:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38KJ1fsF031173;
        Wed, 20 Sep 2023 19:55:23 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5r6m0swm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:55:23 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38KJtMkY656108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 19:55:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3CB358056;
        Wed, 20 Sep 2023 19:55:22 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F4285803F;
        Wed, 20 Sep 2023 19:55:22 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.177.27])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 20 Sep 2023 19:55:22 +0000 (GMT)
Message-ID: <68edc78203739b7cabf51c21ef53a03d4eac215b.camel@linux.ibm.com>
Subject: Re: Linux IMA documentation
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>
Date:   Wed, 20 Sep 2023 15:55:22 -0400
In-Reply-To: <087c8835-5f4b-4df3-8a7e-30b95c78a8c0@linux.ibm.com>
References: <a5ed5a0f-5692-426e-d058-983cf4d9cccb@linux.ibm.com>
         <CUUY4NO1I9DA.1S0KWKJVHQ8K5@seitikki>
         <6ea76738-f587-087d-60ea-ed03adedab62@linux.ibm.com>
         <CVAGSGSJ0NC2.1OQUGKH4ZR0ZB@suppilovahvero>
         <5800e76f-bae5-b3c8-9d0d-51584c93d4ad@linux.ibm.com>
         <ea3dc0b080d6ed56c2f90793017d2908ba15718f.camel@huaweicloud.com>
         <087c8835-5f4b-4df3-8a7e-30b95c78a8c0@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Bl59Kl4PevWPlpo7CvPNNH9Yh9kxJoTw
X-Proofpoint-ORIG-GUID: Bl59Kl4PevWPlpo7CvPNNH9Yh9kxJoTw
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_09,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=633 clxscore=1011 mlxscore=0
 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200163
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-09-20 at 15:02 -0400, Ken Goldman wrote:
> On 9/13/2023 10:16 AM, Roberto Sassu wrote:
> > I think your document is a good candidate for being put in 
> > Documentation/admin-guide/LSM/, once my patch set is upstreamed: 
> > https://lore.kernel.org/linux-integrity/20230904133415.1799503-1-roberto.sassu@huaweicloud.com/
> 
> Isn't the documentation separate from this proposed patch?  It doesn't 
> claim to document how code works.

Roberto suggested putting the documentation in the LSM documentation
directory after his patch set is upstreamed.   Only then will IMA/EVM
be considered full LSMs.

Mimi

