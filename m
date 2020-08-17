Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67264247843
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 22:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHQUnX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 16:43:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbgHQUnT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 16:43:19 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HKgUIo185682;
        Mon, 17 Aug 2020 16:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1nLf40E4gF14fzxXPCJyZRGuu2Yhxjx3oE/IMN7M+Jk=;
 b=I5IdPebnuROuVDDlclUkS/gOWnaqYalo1V/s2XYoktARCNQLYrOIcoftcIfxAJ9Iz3NI
 mrCxgDKBayG2b7T3u7B7Oym9pQLHag+Ef0Giarh/cCHhj4VB56VnYuL1P2v/PfUXmrnq
 j7vbklk9j1AJUhQEJCaFwBaIERqDdG8jNW2mbxqDGKrJtQ9J0FTPr+BwdKWQ/pKoIipD
 bBNTH9MFh40l7dFGFhlRt8Wl223diSEy+IYQKUXIceaINAWilYSmxId16AEZqFgEN9Z1
 gnG9El5a+J30vqxqrj0imy5KZPI9GDKcmBWrxPDFQg2aF7KZh8pk3q9nOAwp8pIk0A29 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32y4f4aj5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 16:43:12 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07HKh8sc189640;
        Mon, 17 Aug 2020 16:43:12 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32y4f4aj4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 16:43:11 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07HKfCro008572;
        Mon, 17 Aug 2020 20:43:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 32x7b82mt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 20:43:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07HKfceR62390554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 20:41:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09143A4059;
        Mon, 17 Aug 2020 20:43:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87B87A4040;
        Mon, 17 Aug 2020 20:43:03 +0000 (GMT)
Received: from sig-9-65-192-88.ibm.com (unknown [9.65.192.88])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Aug 2020 20:43:03 +0000 (GMT)
Message-ID: <591b5f09c7df8ef0378866eaf3afde7a7cb4e82f.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] IMA: add policy to support measuring critical data
 from kernel components
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        nramas@linux.microsoft.com
Date:   Mon, 17 Aug 2020 16:43:02 -0400
In-Reply-To: <20200812193102.18636-3-tusharsu@linux.microsoft.com>
References: <20200812193102.18636-1-tusharsu@linux.microsoft.com>
         <20200812193102.18636-3-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_14:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=3
 clxscore=1011 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170136
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-08-12 at 12:31 -0700, Tushar Sugandhi wrote:
> There would be several candidate kernel components suitable for IMA
> measurement. Not all of them would be enlightened for IMA measurement.
> Also, system administrators may not want to measure data for all of
> them, even when they are enlightened for IMA measurements. An IMA policy
> specific to various kernel components is needed to measure their
> respective critical data.
> 
> Add a new IMA policy CRITICAL_DATA+data_sources to support measuring
> various critical kernel components. This policy would enable the
> system administrators to limit the measurement to the components,
> if the components are enlightened for IMA measurement.

"enlightened", really?  Please find a different term, maybe something
like "supported".

Before posting a patch set, please look at the patches line by line,
like anyone reviewing the code needs to do.  Please minimize code
change.   Unnecessary formatting changes are unacceptible.   For
example, like the "#define", below, or in 3/3 the
"process_buffer_measurement()" change from void to int.

scripts/Lindent isn't as prevalent as it used to be, but it's still
included in Documentation/process/coding-style.rst.  Use it as a guide.

Mimi

