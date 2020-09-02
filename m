Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC05425B4D2
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Sep 2020 21:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIBTzc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Sep 2020 15:55:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgIBTzb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Sep 2020 15:55:31 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082JcAus088084;
        Wed, 2 Sep 2020 15:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0Ea0UcfMe7PHsrVD0pFOiv8VCaP3XQXJw+mmhy0kNNI=;
 b=smAOh1vp77+krhOR+OeLIDMQOZBPjysMP4piRZ0DlNug5kBuKNY29qDhcQlmpw2APScC
 MltcABAA2oB9SdFDxc1n+bTtAVK6owkaodfN+HiHrGZrz7Rz4I/wCWaMULSgIRX8Nx5B
 2Xp2T+g+om7rgyTJlASCHtCYLxbc908pnFZCyWL7GvuYRiMGO6kBzZbPlfQvP1/fGRbd
 gycVy7KtNJ4Ck94fYmyxBnO+Z6vffeIHFk45mCj3fp4su0x3rH0RiQP4dTmmgGlM91b9
 Fu0kqEO4mjRYI5mEXMrJuuNebPUqCFWNGsHci1fz65eKbCVS3waZxiFvSeTMUWs5M8fA Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33afsubr8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 15:55:09 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 082JcBUT088215;
        Wed, 2 Sep 2020 15:55:08 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33afsubr7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 15:55:08 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 082JpFm6029703;
        Wed, 2 Sep 2020 19:55:05 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 337en8d261-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 19:55:05 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 082Jt36962325230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 19:55:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81FA4A405B;
        Wed,  2 Sep 2020 19:55:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C8FAA405F;
        Wed,  2 Sep 2020 19:54:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.121.98])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 19:54:59 +0000 (GMT)
Message-ID: <d77a6cd783319702fddd06783cb84fdeb86210a6.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 00/30] ima: Introduce IMA namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        krzysztof.struczynski@huawei.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, stefanb@linux.vnet.ibm.com,
        sunyuqiong1988@gmail.com, mkayaalp@cs.binghamton.edu,
        dmitry.kasatkin@gmail.com, serge@hallyn.com, jmorris@namei.org,
        christian@brauner.io, silviu.vlasceanu@huawei.com,
        roberto.sassu@huawei.com, ebiederm@xmission.com,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        luto@amacapital.net, jannh@google.com
Date:   Wed, 02 Sep 2020 15:54:58 -0400
In-Reply-To: <20200818164943.va3um7toztazcfud@wittgenstein>
References: <N> <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
         <20200818164943.va3um7toztazcfud@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_14:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020178
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-08-18 at 18:49 +0200, Christian Brauner wrote:
> On Tue, Aug 18, 2020 at 05:20:07PM +0200, krzysztof.struczynski@huawei.com wrote:
> > From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
> > 
> > IMA has not been designed to work with containers. It handles every
> > process in the same way, and it cannot distinguish if a process belongs to
> > a container or not.
> > 
> > Containers use namespaces to make it appear to the processes in the
> > containers that they have their own isolated instance of the global
> > resource. For IMA as well, it is desirable to let processes in the
> 
> IMA is brought up on a regular basis with "we want to have this" for
> years and then non-one seems to really care enough.

There is a lot of interest in IMA namespacing, but the question always
comes back to how to enable it.  Refer to  
https://kernsec.org/wiki/index.php/IMA_Namespacing_design_considerations
 for Stefan's analysis.

I understand "containers" is not a kernel construct, but from my very
limited perspective, IMA namespacing only makes sense in the context of
a "container".  The container owner may want to know which files have
been accessed/executed (measurements, remote attestation) and/or
constrain which files may be accessed/executed based on signatures
(appraisal).

> 
> I'm highly skeptical of the value of ~2500 lines of code even if it
> includes a bunch of namespace boilerplate. It's yet another namespace,
> and yet another security framework.
> Why does IMA need to be a separate namespace? Keyrings are tied to user
> namespaces why can't IMA be? 

In the context of a container, the measurement list and IMA/EVM
keyrings need to be setup before the first file is measured, signature
verified, or file hash included in the audit log.

> I believe Eric has even pointed that out
> before.
> 
> Eric, thoughts?

Any help with the above scenario would very be much appreciated.

Mimi

