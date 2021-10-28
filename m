Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1553F43D820
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Oct 2021 02:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhJ1A3x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Oct 2021 20:29:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhJ1A3w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Oct 2021 20:29:52 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RNHede018520;
        Thu, 28 Oct 2021 00:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=OznvqQjdw9vxFKRHhPOVS9QkvjjvRDbF3mcynjsocYc=;
 b=JTbwLgd/SnZbFNYDjNsEraK2b2CWkHGjL3cvAzAtKbG78BvNKqKIrC4NfukubZdoQ6Nu
 JF+7kfAlcUBuaTzVWDJ+dDnhIetrdqMbelOXecB/433JqrtXUHeEpxbj+OjBDKVFN1w2
 iCw8vQV8F4beilNWbjXkUV/GeuUROysWo0H7RcqTAJP0jNDNyOIBbwtXNwLbDWoz/i9P
 hejXQJQyWFFipfqZ2k81LZjop8yM4AFpL9v3GOS/AsKngASbUDC5hHd6skoXAdiDf28g
 urEwJCyzsdHrGc44Vv8vI9LzjR9ytrt/lpppyJwMFPcpEtsGcqs5GSxVLhIecZtt6dq9 lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bygam8wgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 00:27:14 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19S0BJxo009743;
        Thu, 28 Oct 2021 00:27:14 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bygam8wgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 00:27:13 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19S0ITep031059;
        Thu, 28 Oct 2021 00:27:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3bx4ej2m8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 00:27:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19S0R8go47841646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 00:27:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 422F55204F;
        Thu, 28 Oct 2021 00:27:08 +0000 (GMT)
Received: from sig-9-65-78-33.ibm.com (unknown [9.65.78.33])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 16FAB5204E;
        Thu, 28 Oct 2021 00:27:06 +0000 (GMT)
Message-ID: <f675255eae2bc97bc571f7e798a952ea3d24e4d6.camel@linux.ibm.com>
Subject: Re: [PATCH] ima/evm: mark evm_fixmode as __ro_after_init
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Austin Kim <austindh.kim@gmail.com>, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        kernel-team@lge.com
Date:   Wed, 27 Oct 2021 20:27:06 -0400
In-Reply-To: <20211026224354.GA13009@raspberrypi>
References: <20211026224354.GA13009@raspberrypi>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nyD-Hd56wr-mx6Ec9R9pUzT6mNb9ip7v
X-Proofpoint-GUID: WYII5y4IAi8JL-PUmenvGiB5sQ5yyoM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_07,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=783 clxscore=1011 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110270131
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Austin,

The subject line should be just "evm:".

On Tue, 2021-10-26 at 23:43 +0100, Austin Kim wrote:
> From: Austin Kim <austin.kim@lge.com>
> 
> evm_fixmode global variable is never modified
> outside initcalls, so declaring it with __ro_after_init is better.

Please properly format the text.  From
Documentation/process/submitting-patches.rst:

  - The body of the explanation, line wrapped at 75 columns, which will
    be copied to the permanent changelog to describe this patch.

> 
> Signed-off-by: Austin Kim <austin.kim@lge.com>

Otherwise,
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

