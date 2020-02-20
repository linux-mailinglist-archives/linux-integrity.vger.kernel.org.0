Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5947E166ABF
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2020 00:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgBTXHX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Feb 2020 18:07:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727135AbgBTXHX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Feb 2020 18:07:23 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KN4bB1017651
        for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2020 18:07:22 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y9sbuvvur-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2020 18:07:22 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 20 Feb 2020 23:07:20 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Feb 2020 23:07:18 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01KN7HLX44826762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 23:07:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BF0DAE051;
        Thu, 20 Feb 2020 23:07:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E34EAE04D;
        Thu, 20 Feb 2020 23:07:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.145.184])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Feb 2020 23:07:15 +0000 (GMT)
Subject: Re: [PATCH v5 0/3] integrity: improve log messages
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, joe@perches.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Feb 2020 18:07:15 -0500
In-Reply-To: <20200219000611.28141-1-tusharsu@linux.microsoft.com>
References: <20200219000611.28141-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022023-0020-0000-0000-000003AC1616
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022023-0021-0000-0000-000022041DC0
Message-Id: <1582240035.5121.0.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_18:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=892 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200169
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-02-18 at 16:06 -0800, Tushar Sugandhi wrote:
> The log messages from integrity subsystem should be consistent for better
> diagnosability and discoverability.
> 
> This patch set improves the logging by removing duplicate log formatting
> macros, adding a consistent prefix to the log messages, and adding new 
> log messages where necessary.

Thanks!  This patch set is now queued in the next-integrity-testing branch.

Mimi

