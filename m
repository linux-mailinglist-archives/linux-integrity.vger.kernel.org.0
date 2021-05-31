Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17743964F2
	for <lists+linux-integrity@lfdr.de>; Mon, 31 May 2021 18:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhEaQRq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 May 2021 12:17:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65154 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234462AbhEaQOi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 May 2021 12:14:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14VG4Bw7007815;
        Mon, 31 May 2021 12:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=c5r4n5kknRtYc7lrqF3Te3pmwP+8R1b5OIQ5aDCuDhM=;
 b=tRBMMo6vmbbTnGZyOW0eTGR29eE4uPmKzasw9ivlrofEDOy3fySbHVpDAv6VGyltxj7K
 /JLUFfy4sGmitPfNB16k84HLuwZYCLbMkNGim+I9SCBWKY6/KgqhKSUyrh2XfCWCoZMg
 mGrEEAiJxjJZnfrtbLRQPP/+B1wFLAQLZsyysOeXCbjEwRf4/VRNYVdMbFuNwFR7HUTK
 4CNSP7gnjxl/OE++lBQIpsbHZpSLVH7m3/jZTcdisdRFdnGX0HQI6shiisA5+c6PptKr
 FCuL0exp1tz54DdNSRBHihoZ291OJvOI12Oaki31e7EJxpxXNZuAL31vo7gu3o/OJ5K2 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38w2s40fpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 12:12:57 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14VG4Rc3009168;
        Mon, 31 May 2021 12:12:57 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38w2s40fnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 12:12:56 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14VGCs6C012269;
        Mon, 31 May 2021 16:12:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 38ucvh94vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 16:12:54 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14VGCptR22085984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 16:12:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83885A4054;
        Mon, 31 May 2021 16:12:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48482A405F;
        Mon, 31 May 2021 16:12:49 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.84.117])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 May 2021 16:12:49 +0000 (GMT)
Message-ID: <184416d80a6f39c9e73a383e0959c389e7c32340.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] certs: Trigger creation of RSA module signing
 key if it's not an RSA key
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, jeyu@kernel.org,
        keyrings@vger.kernel.org, dhowells@redhat.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 31 May 2021 12:12:40 -0400
In-Reply-To: <20210423151247.1517808-2-stefanb@linux.ibm.com>
References: <20210423151247.1517808-1-stefanb@linux.ibm.com>
         <20210423151247.1517808-2-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G0_rLNi-uRT_Pu2ybYwPNAWbx7fpLGPq
X-Proofpoint-GUID: qtFHi1lVmgxXPZktWzxb20xuu3NH8itp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-31_10:2021-05-31,2021-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105310119
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-04-23 at 11:12 -0400, Stefan Berger wrote:
> Address a kbuild issue where a developer created an ECDSA key for signing
> kernel modules and then builds an older version of the kernel, when bi-
> secting the kernel for example, that does not support ECDSA keys.
> 
> Trigger the creation of an RSA module signing key if it is not an RSA key.
> 
> Fixes: cfc411e7fff3 ("Move certificate handling to its own directory")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Tested-by: Mimi Zohar <zohar@linux.ibm.com>

