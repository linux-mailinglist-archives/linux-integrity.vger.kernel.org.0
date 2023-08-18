Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1EF7815BB
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Aug 2023 01:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbjHRXSR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Aug 2023 19:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242939AbjHRXSN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Aug 2023 19:18:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A67D35A6
        for <linux-integrity@vger.kernel.org>; Fri, 18 Aug 2023 16:18:05 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IN2KHl008841;
        Fri, 18 Aug 2023 23:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=4jJ2KqO2SeJBBX27XClF6Fl9V++knOGzbF7pbfVMa+Y=;
 b=jxb0jd/gDYpzO4uD+phYyuRu/xQ6+Cldk/Bjv7jXmKc1vT6BKygUwfvInAR9iDyanFxG
 qtHCSbibD8CgTjAVQ4df4EbTOPzpfjjfUlsByH9/Cp6DoSuPYzLIEGr/466PyWLvOwdU
 tnj/ToOpW4AcmAGtPEq2McOfEUR5pINcYe1FRZmMjMMU7llskQbCTh7A+H5Hk4js/EgG
 bSsojqzISmpwZKD2Hxdle3H6iuo0DOo7ThbvFjGMpVOThrxUJrsr2qk8ZkSrbWCqDLa5
 HJrvfm7Fs01pAB+d07VPtzIHxmMaQpl2HKHvORX1PAbbC7aoMu1jHfT8fpJu4A6WK4vJ RQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjhydr7jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 23:17:56 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IMZBcd001119;
        Fri, 18 Aug 2023 23:17:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semt0339k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 23:17:55 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37INHtCI62652852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 23:17:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0FCD58055;
        Fri, 18 Aug 2023 23:17:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DF315804B;
        Fri, 18 Aug 2023 23:17:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.57.160])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 18 Aug 2023 23:17:54 +0000 (GMT)
Message-ID: <97198ee38422fbb1891981ac5c41263d5b03b321.camel@linux.ibm.com>
Subject: Re: [RFC PATCH -next] ima: Make tpm hash configurable
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-integrity@vger.kernel.org
Date:   Fri, 18 Aug 2023 19:17:37 -0400
In-Reply-To: <e2c5711c-6549-e81f-42a7-eec176b39d63@huawei.com>
References: <20230817061334.1910-1-guozihua@huawei.com>
         <90b4b5573182ec68b2da2f9ef2bc6567d724f8f1.camel@linux.ibm.com>
         <e2c5711c-6549-e81f-42a7-eec176b39d63@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tFgGrWzWQD0LU9kCElPXovST7fwMGu3v
X-Proofpoint-GUID: tFgGrWzWQD0LU9kCElPXovST7fwMGu3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_26,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 impostorscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180212
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-08-18 at 09:25 +0800, Guozihua (Scott) wrote:
> On 2023/8/17 22:19, Mimi Zohar wrote:
> > On Thu, 2023-08-17 at 14:13 +0800, GUO Zihua wrote:
[...]
 
> > Other proposals have changed the hard coded hash algorithm and PCR
> > value from SHA1 to SHA256.  Both that proposal and this will break
> > existing userspace applications.
> 
> This is the part I would like to "RFC" on, and thanks for the comment!

Another proposal included all of the enabled TPM bank digests.

> In deed this change should break userspace as well as all the existing
> remote attestation implementation. It should be better to have a brand
> new file for this.

True SHA1 is being phased out due to hash collisions.  Verifying the
template data hash against the template data isn't necessary for the
attestation server to verify a TPM quote against any of the enabled TPM
banks.  The attestation server walks the measurement list calculating
the bank specific template data hash.  Breaking existing applications
is unreasonable.

> > 
> > Before we can introduce this sort of change, we would need to introduce
> > an IMA measurement list version.  Perhaps its time to define an IMA
> > security critical-dbata record, which would include this and other
> > information.  The measurement list itself would need to include a
> > version number.
> > 
> I guess one of the easy way to do it is to make a
> ascii_runtime_measurements_ng and binary_runtime_measurements_ng, which
> contains a changed template supporting configurable template hash. What
> do you think?

Defining additional pseudo filesystems would allow both the old and new
measurement list formats to be enabled at the same time.

-- 
thanks,

Mimi

