Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DF94275F
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2019 15:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437482AbfFLNY0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jun 2019 09:24:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437469AbfFLNY0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 09:24:26 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CDIYJ6014136
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jun 2019 09:24:25 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t31263qga-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jun 2019 09:24:24 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 12 Jun 2019 14:24:20 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Jun 2019 14:24:17 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5CDO9jc35586544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 13:24:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2267611C069;
        Wed, 12 Jun 2019 13:24:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F08C811C04A;
        Wed, 12 Jun 2019 13:24:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.218])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jun 2019 13:24:14 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] ima: use the lsm policy update notifier
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>, sds@tycho.nsa.gov,
        paul@paul-moore.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 12 Jun 2019 09:24:04 -0400
In-Reply-To: <20190612074456.2504-2-janne.karhunen@gmail.com>
References: <20190612074456.2504-1-janne.karhunen@gmail.com>
         <20190612074456.2504-2-janne.karhunen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061213-0028-0000-0000-00000379A8C4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061213-0029-0000-0000-000024399D6A
Message-Id: <1560345844.4578.15.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906120092
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-06-12 at 10:44 +0300, Janne Karhunen wrote:
> Don't do lazy policy updates while running the rule matching,
> run the updates as they happen.
> 
> Depends on commit 141a61ce6c60 ("LSM: switch to blocking policy update notifiers")
> 
> Changelog v2
> - Rebase to 'next-queued-testing'
> - Use memset to initialize the lsm rule array
> - Don't duplicate elements that are immutable during the rule copy
> 
> =========
> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> 

Thanks, this looks a lot better.

Mimi

