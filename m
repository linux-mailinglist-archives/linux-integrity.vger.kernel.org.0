Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D505347646A
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Dec 2021 22:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhLOVQQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 16:16:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhLOVQQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 16:16:16 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFKMigB006331;
        Wed, 15 Dec 2021 21:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=r1/Oo1kyddJ7iuoNqUgzDeZ8tr/sCHoqm/0C/JjKL60=;
 b=i3l1suvG3440rFJziRMQ0/rjYlShQINEqt+ecEEJZEoi1pTHT589rMVGsJv8rFg0TYiN
 D0x1awLYKZ+DtwrV5JB/d0jZoDUmlfcDreyOVrhdvDUeR0m8wXkl1kExmqDmMAeD7M1t
 b7cbtXcB3wnrdKif022I6QjsqpRCh5gqbzYf2ncOfFJvWcxoPdgBk2OVuDY8Ke4pPOoC
 WW75vUozZq9BFGp01nKUe5koRvzaPNBrIQpzIu3+A/dWE7ML1pOcQoiusWUUb/meStoN
 Uc2xNDIq3CH4AlQFjYQ+Q27pKJfwn5Aa2dYRZ8jCkigNtO34UjxCnBTtp1/XAkQA0Do8 lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyqbhgx96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 21:16:05 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BFLG4T1032076;
        Wed, 15 Dec 2021 21:16:04 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyqbhgx88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 21:16:04 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BFLCn1m024453;
        Wed, 15 Dec 2021 21:16:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3cy7jr1217-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 21:16:01 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BFLFwGw47710678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 21:15:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6420A405C;
        Wed, 15 Dec 2021 21:15:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1617AA4060;
        Wed, 15 Dec 2021 21:15:56 +0000 (GMT)
Received: from sig-9-65-74-182.ibm.com (unknown [9.65.74.182])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Dec 2021 21:15:55 +0000 (GMT)
Message-ID: <925ed27a6375dffcb92e9812e36b1c461ae63aa2.camel@linux.ibm.com>
Subject: Re: [PATCH v6 03/17] ima: Namespace audit status flags
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Date:   Wed, 15 Dec 2021 16:15:55 -0500
In-Reply-To: <20211210194736.1538863-4-stefanb@linux.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
         <20211210194736.1538863-4-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OhkSsN2HvKSugWB1AyCNBJwn0KH2n4EX
X-Proofpoint-ORIG-GUID: 9nmbmPhHwTxWg_ZTZ2w47i4rbBE4fqES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_12,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=944 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112150116
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-12-10 at 14:47 -0500, Stefan Berger wrote:
> From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
> 
> The iint cache stores whether the file is measured, appraised, audited
> etc. This patch moves the IMA_AUDITED flag into the per-namespace
> ns_status, enabling IMA audit mechanism to audit the same file each time
> it is accessed in a new namespace.
> 
> The ns_status is not looked up if the CONFIG_IMA_NS is disabled or if
> any of the IMA_NS_STATUS_ACTIONS (currently only IMA_AUDIT) is not
> enabled.

^none of the ... are enabled.

thanks,

Mimi

> 
> Read and write operations on the iint flags is replaced with function
> calls. For reading, iint_flags() returns the bitwise AND of iint->flags
> and ns_status->flags. The ns_status flags are masked with
> IMA_NS_STATUS_FLAGS (currently only IMA_AUDITED). Similarly
> set_iint_flags() only writes the masked portion to the ns_status flags,
> while the iint flags is set as before. The ns_status parameter added to
> ima_audit_measurement() is used with the above functions to query and
> set the ns_status flags.
> 

