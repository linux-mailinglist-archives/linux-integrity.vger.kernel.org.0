Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F17131F2B8
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 00:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBRXC7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Feb 2021 18:02:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhBRXC7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Feb 2021 18:02:59 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11IMXFxi178716;
        Thu, 18 Feb 2021 18:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9yf/exikxb14aBP182cqL+okn4giAyPqoa0K6EQ+Crc=;
 b=cbq2aM6CyMgG9ajmDp8gY2ot7pA23dEakHLIQxSAxz8BYbUE6ZOF786tWnArdqYDnkni
 sZkQr/gcQmpuMKQMU1wO1gSDTsXNObt5/jJySoIUCiAlDEm2RoGQI4x2Wu4+2EB/KlDU
 m6xYHV0rGH0EX9JBNxxZfcAmdRxIq0MS+WjyJ97MzqD+fAXaThvcbHH10MeLj/ksjv7w
 iGOSMFgomcWAi+l2O4zBKdI9jSfG1DPnH9dfqHQa0yEaa9xDery8S5U5zoXVh6pFJDfy
 BbYkPPWpyU1Rm7tv+dgMZsPFX1leWx5hYjsa568BrR4q17/Bmb7PrZ03TwqrTXnjHHSA vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36sy3auwe9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 18:02:17 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11IMXLpu182431;
        Thu, 18 Feb 2021 18:02:16 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36sy3auwd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 18:02:16 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11IN2Ei5005209;
        Thu, 18 Feb 2021 23:02:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 36p6d8d2pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 23:02:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11IN2ASg41025948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 23:02:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF419A405C;
        Thu, 18 Feb 2021 23:02:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA171A405F;
        Thu, 18 Feb 2021 23:02:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.66.70])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Feb 2021 23:02:08 +0000 (GMT)
Message-ID: <000c7600b041a9c513d37b126ecfa6debdd0c738.camel@linux.ibm.com>
Subject: Re: [PATCH v2 5/5] ima: enable loading of build time generated key
 on .ima keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 18 Feb 2021 18:02:07 -0500
In-Reply-To: <20210218220011.67625-6-nayna@linux.ibm.com>
References: <20210218220011.67625-1-nayna@linux.ibm.com>
         <20210218220011.67625-6-nayna@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_14:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180188
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-02-18 at 17:00 -0500, Nayna Jain wrote:
> The kernel currently only loads the kernel module signing key onto
> the builtin trusted keyring. To support IMA, load the module signing
> key selectively either onto the builtin or IMA keyring based on MODULE_SIG
> or MODULE_APPRAISE_MODSIG config respectively; and loads the CA kernel
> key onto the builtin trusted keyring.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Always having a CA key would simplify the code.   Otherwise for the
patch set,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

