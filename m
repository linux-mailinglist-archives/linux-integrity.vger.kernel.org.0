Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946DC25B41D
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Sep 2020 20:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIBSxr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Sep 2020 14:53:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726124AbgIBSxo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Sep 2020 14:53:44 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082IWCL2121893;
        Wed, 2 Sep 2020 14:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=D8h2MQ2BFxQFN1LZrIEeY+TR98t0M6uXFJff0XnwfCo=;
 b=nO/4CuY3MHL193LgWq2pWOz32bp8Wps5HPZ1D15dg+xwybGLqQGGr+ewLMi6AJ7TE+U4
 V9chqW9Lh2zqOMH5EA3kTBjhqnUHroMrkPvUJSC1bsey12HRVPiJKXPMN8chFF+HeSBG
 DgtR7K6nZQMqwV6e0/AwFuWyk1Ej/Cp11y7Ul/jN6VceIOyBVP4PEeqpRW4Yq+r12yxW
 JLS2CsBgPFt4VU1v2kv0TZejCZXUngVgA/PJ/0q4+H0R3ohiDY6zSBylP9oi0+bdBXYe
 OqSYZ2kKyFMsutfd+hfmCAgo7NQXcNyKrgjMtIna8lCrpWJo/PtdMUVfL3j4LoWOVBHT IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33agp70p4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 14:53:25 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 082IWHbV122282;
        Wed, 2 Sep 2020 14:53:25 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33agp70p42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 14:53:25 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 082Ir06n023126;
        Wed, 2 Sep 2020 18:53:23 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 339ap7sd77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 18:53:23 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 082IrLMC25166286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 18:53:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53F3211C04C;
        Wed,  2 Sep 2020 18:53:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A81211C04A;
        Wed,  2 Sep 2020 18:53:18 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.121.98])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 18:53:18 +0000 (GMT)
Message-ID: <5331e60b5a1afb55e2bc778db1b95998466b687d.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 00/30] ima: Introduce IMA namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Cc:     "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>,
        "sunyuqiong1988@gmail.com" <sunyuqiong1988@gmail.com>,
        "mkayaalp@cs.binghamton.edu" <mkayaalp@cs.binghamton.edu>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "christian@brauner.io" <christian@brauner.io>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 02 Sep 2020 14:53:17 -0400
In-Reply-To: <401a2f36149f450291d1742aeb6c2260@huawei.com>
References: <N> <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
         <1597767571.3898.15.camel@HansenPartnership.com>
         <401a2f36149f450291d1742aeb6c2260@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_12:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009020170
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-08-21 at 15:13 +0000, Krzysztof Struczynski wrote:
> > From: James Bottomley [mailto:James.Bottomley@HansenPartnership.com]
> > On Tue, 2020-08-18 at 17:20 +0200, krzysztof.struczynski@huawei.com
> > wrote:
> > > The measurement list remains global, with the assumption that there
> > > is only one TPM in the system. Each IMA namespace has a unique ID,
> > > that allows to track measurements per IMA namespace. Processes in one
> > > namespace, have access only to the measurements from that namespace.
> > > The exception is made for the initial IMA namespace, whose processes
> > > have access to all entries.
> > 
> > So I think this can work in the use case where the system owner is
> > responsible for doing the logging and attestation and the tenants just
> > trust the owner without requiring an attestation.  However, in a multi-
> > tenant system you need a way for the attestation to be per-container
> > (because the combined list of who executed what would be a security
> > leak between tenants).  Since we can't virtualise the PCRs without
> > introducing a vtpm this is going to require a vtpm infrastructure like
> > that used for virtual machines and then we can do IMA logging per
> > container.
> 
> I agree and wonder if we should decouple the attestation trust model,
> which depends on the specific use case (e.g. multi/single tenant,
> public/private cloud), from the IMA logic of linking the measurements to
> the container. Indeed, attestation from within the container might require
> anchoring to a vTPM/vPCR and the current measurement tagging mechanism can
> support several ways of anchoring them to a (virtual) root of trust.
> 
> > I don't think the above has to be in your first patch set, we just have
> > to have an idea of how it could be done to show that nothing in this
> > patch set precludes a follow on from doing this.
> 
> Given that virtualizing trust anchors seems like a separate problem in
> which industry consensus is not easy to reach for all use cases, an
> anchoring mechanism should probably be a separate IMA feature.

Other trust anchors for "trusted keys" has been discussed, but I wasn't
aware of any discussion about other trust anchors for the IMA
measurement list.  The IMA measurement list is very much tied to a TPM.

Including container measurements in the host measurement list, will
unnecessarily cause the host measurement list to grow.  The decision of
what should and shouldn't be included in the host measurement list
shouldn't be defined by the container.

Mimi



