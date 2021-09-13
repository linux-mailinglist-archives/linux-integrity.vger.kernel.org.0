Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83423409A18
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 18:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbhIMQzk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 12:55:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240767AbhIMQzg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 12:55:36 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DGrAV8021839
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 12:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=vrwZIqA0/yyqYnncHpuHuIfKWxH0p6nwDohUge3P8HY=;
 b=AUYnE3rJYtc9evsUyiv+m5ION1y09pjpDLtJBYfIOE1UXmnQdiI8Vv6pPSgig0XiYsek
 uIxUb1swKkUiFYWJ1GVGw4DYD2jZR3nJ7EKPz1FzZx9rnLnGRNJe4PqPTMZsK+QUzfuh
 sCSDYA0PyCdEsKbL2BoO+msGn/64D7xqlyzQ1iuVCBjlkB5tSUI9g0Vyd9Q5sidM0X5i
 2/Iu5WycB0ljKKtpXw8hwePt7h8tcNgIcbFoG26dfGeJE5auWPoqevEiBPNIMgjxmC89
 WxpgLsOjGqIEs5YHl+YW5wv3LQbRn6Jgm9UJF1iyxgQkhwzgc+4n/CKffK41nNO1+4Q3 oA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b232ad8f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 12:54:18 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DGsBKh018499
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 16:54:17 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3b0m39292p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 16:54:17 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DGnlGA57344396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 16:49:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0556411C054;
        Mon, 13 Sep 2021 16:54:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DE3F11C04C;
        Mon, 13 Sep 2021 16:54:13 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.27.52])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Sep 2021 16:54:12 +0000 (GMT)
Message-ID: <dc523a2eac15a8d8134eb2a53fdb2ee90f774218.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/9] evmctl: Implement function for setting up an
 OpenSSL engine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Date:   Mon, 13 Sep 2021 12:54:12 -0400
In-Reply-To: <20210908192343.4147739-4-stefanb@linux.vnet.ibm.com>
References: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
         <20210908192343.4147739-4-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9l9w_QNUm3pxuykWtugvM5ISMsK-E50A
X-Proofpoint-ORIG-GUID: 9l9w_QNUm3pxuykWtugvM5ISMsK-E50A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=846 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109130042
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-09-08 at 15:23 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Implement setup_engine for setting up an OpenSSL engine.

Duplicating the subject line like this, isn't any different than
leaving out the patch description.  Please provide a proper patch
description (e.g. code cleanup).

thanks,

Mimi

