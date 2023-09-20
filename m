Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2AE7A8C35
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Sep 2023 21:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjITTDK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Sep 2023 15:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjITTDJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Sep 2023 15:03:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DDDAF
        for <linux-integrity@vger.kernel.org>; Wed, 20 Sep 2023 12:03:03 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KIbnZ1016906;
        Wed, 20 Sep 2023 19:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=HUix2lSDR3I3qtVMF49a3fEciGisDVXtDY43w08EeQM=;
 b=ELwJZ4ogjmNJDbLCnfD79OdbmJ7CrdcsxNgg5XCZGhuTfCqTrOIMvSB6cUqFwXBTzFZp
 jpOTQM7P+ATo520AEdwNxMjqIWcuvmDDOpkqBBpUsuH2S4EyQJjFm+8gqF2DH/+aEFEY
 9gf8gJHn+irpxICqy1snevf5Qtk3ixdrVMkvVeWtke8gEk1SrHtjVlyXarTTet0xG4bI
 jOW8sWG5jGxzdeikP8Y+r5JezYQ6T44+mQUKIdNwPgr0CRf1nBnChFz36PRu3/XLm2Le
 mKSV7lcIVofCnbwcOGj64Z4kH91QPLtZ2p+gA0Hpei/nXhfkJKJfLj6/lBx5ty4vltRx Fg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t81v8s9ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:02:51 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38KHaoV2016455;
        Wed, 20 Sep 2023 19:02:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd2843m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 19:02:51 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38KJ2o5B6226454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 19:02:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 536C658059;
        Wed, 20 Sep 2023 19:02:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D610458066;
        Wed, 20 Sep 2023 19:02:49 +0000 (GMT)
Received: from [9.67.79.231] (unknown [9.67.79.231])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 20 Sep 2023 19:02:49 +0000 (GMT)
Message-ID: <087c8835-5f4b-4df3-8a7e-30b95c78a8c0@linux.ibm.com>
Date:   Wed, 20 Sep 2023 15:02:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Linux IMA documentation
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>
References: <a5ed5a0f-5692-426e-d058-983cf4d9cccb@linux.ibm.com>
 <CUUY4NO1I9DA.1S0KWKJVHQ8K5@seitikki>
 <6ea76738-f587-087d-60ea-ed03adedab62@linux.ibm.com>
 <CVAGSGSJ0NC2.1OQUGKH4ZR0ZB@suppilovahvero>
 <5800e76f-bae5-b3c8-9d0d-51584c93d4ad@linux.ibm.com>
 <ea3dc0b080d6ed56c2f90793017d2908ba15718f.camel@huaweicloud.com>
Content-Language: en-US
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <ea3dc0b080d6ed56c2f90793017d2908ba15718f.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Enlz393aryw72EP6nL83CIOKfsUyny4q
X-Proofpoint-ORIG-GUID: Enlz393aryw72EP6nL83CIOKfsUyny4q
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_08,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=666 clxscore=1011 mlxscore=0
 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200154
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/13/2023 10:16 AM, Roberto Sassu wrote:
> I think your document is a good candidate for being put in 
> Documentation/admin-guide/LSM/, once my patch set is upstreamed: 
> https://lore.kernel.org/linux-integrity/20230904133415.1799503-1-roberto.sassu@huaweicloud.com/

Isn't the documentation separate from this proposed patch?  It doesn't 
claim to document how code works.

What's the process for proposing this work for inclusion in the 
documentation?
