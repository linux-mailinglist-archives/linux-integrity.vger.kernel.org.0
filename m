Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7815BC1A2
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Sep 2022 05:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiISDHv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 18 Sep 2022 23:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiISDHu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Sep 2022 23:07:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFE51A80A
        for <linux-integrity@vger.kernel.org>; Sun, 18 Sep 2022 20:07:49 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J0m7lw015016;
        Mon, 19 Sep 2022 03:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8rITW6cHv2UshN9DFodVsyN7L9fKVFO47m9244sr3dM=;
 b=k07lOZazYoZTUbfJ9nzHRDhAw9dgbTPS+aqbnYstnrj8zX4WN9gjpE1pFwvsehmYPoxl
 BlmFKBjOSZZCKrq1t3mYNq9qWrX+ghSRLO16qBpz1nO6gAa0ziVplwsVUgjyDSC1nm+F
 QnoCbmGpB5FL9oxA6ZJJ1J/mnwE0Twgxab9Ru60xip5IHBaSYYBPVx/cqT88nYue8l1U
 NIwa89WtU3GY0m2DTnq3mnuNoCXm1VwUdf3iRefqRAUxJBc3Wbm/DeKVIm0HnchxlZ/8
 3npzF28dJ04/EbnKBwjOUqcWCNQrZcm4pf/POlDbazcITcBYlanFsgUzN/sLsbm9r5X3 UQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jpe6xt4xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 03:07:45 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28J35KPw013667;
        Mon, 19 Sep 2022 03:07:45 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 3jn5v932jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 03:07:44 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28J37hdY39387742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 03:07:43 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37B60BE05B;
        Mon, 19 Sep 2022 03:26:05 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D76B6BE059;
        Mon, 19 Sep 2022 03:26:04 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.183.187])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 19 Sep 2022 03:26:04 +0000 (GMT)
Message-ID: <2320e083af2bbbc012551c80ed56652bfdbec0f5.camel@linux.ibm.com>
Subject: Re: User questions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     russell@coker.com.au, linux-integrity@vger.kernel.org,
        Ken Williams <ken@williamsclan.us>
Date:   Sun, 18 Sep 2022 23:07:43 -0400
In-Reply-To: <4153672.NgBsaNRSFp@xev>
References: <CADrftwOUDT5CuwHsrgEM1GTu_N3TAhZTpxFBERKa7zwUHkQscw@mail.gmail.com>
         <4153672.NgBsaNRSFp@xev>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _B97rawxEzdF_2EvyDN-DN1yAuPhlO9t
X-Proofpoint-ORIG-GUID: _B97rawxEzdF_2EvyDN-DN1yAuPhlO9t
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_01,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=833 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209190020
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Russell,

> For typical uses of Linux you would want pre-signed executables.  You want to 
> have the system running the programs to not have the signing key and provide 
> the signatures from a trusted system.
> 
> I've been thinking of having some sort of system that proxies the packages of 
> software and creates signatures for them.  The default signing includes the 
> Inode number of the file, that can be disabled or the system installing could 
> say "give me a signature for /bin/bash from package bash version 5.2~rc2-2 
> with Inode 27597791".

EVM portable & immutable signatures do not include the inode.

> 
> The next issue is that the current kernel code doesn't allow signing unsigned 
> files unless you boot with "ima_appraise=fix evm=fix" on the kernel command-
> line.  I've been thinking of writing a kernel patch to give a compile time 
> option to remove that requirement.

When EVM is initialized to only support portable & immutable signatures
(no HMAC key), then the file metadata may be updated.  Refer to the
last paragraph of the cover letter: 
https://lore.kernel.org/linux-integrity/20210514152753.982958-1-roberto.sassu@huawei.com/

--  
thanks,

Mimi

