Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241DF294416
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 22:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409608AbgJTUqE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Oct 2020 16:46:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409605AbgJTUqE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Oct 2020 16:46:04 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09KKWPTd122429;
        Tue, 20 Oct 2020 16:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=U7hAfLRFpDnoLp+5xAJTUGs7elyAAlYCvElKRXv9yxM=;
 b=defH04U+tyDenGAyJyRTLTHOTniann/mtO7I20pLS+419gmWk/TbeYm+I1MpmSNiKXQA
 vadM4DTelUHloam7Y12L6WgiQYJHgdrnDhDdpCX+Ju7I7LPv2ekagSYurp59OLUofNSz
 Tr2pyis47uy9kqw8UADW+UdG9qTuPAwKsShw/fm6Gmn9H+++3DiHiCDcGPkh6UZ/aax+
 5SdQegDUYMYiA4rJKKTiZA5ssEs4ZNCQFhK4DsvTnz5LIwk7XRbwvjUvbpgppvab6+/b
 dPAzSU8eOdgJJyiKEmGF3e6AjnD32qkaDcMQdjDksQMBhhOCBIx/IhCMM2dj3RI816+i oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34a6qq8stb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 16:45:58 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09KKZNh2134434;
        Tue, 20 Oct 2020 16:45:57 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34a6qq8ss2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 16:45:57 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09KKfuVT002853;
        Tue, 20 Oct 2020 20:45:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 347r881vb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 20:45:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09KKjqpW28312006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 20:45:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 484805204F;
        Tue, 20 Oct 2020 20:45:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.35.199])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1903A52051;
        Tue, 20 Oct 2020 20:45:49 +0000 (GMT)
Message-ID: <9aeb4532d84e9d52444d67ff2d2e0e6c438e0a7d.camel@linux.ibm.com>
Subject: Re: [PATCH] security: remove unneeded break
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     trix@redhat.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, jejb@linux.ibm.com,
        jarkko.sakkinen@linux.intel.com, dhowells@redhat.com,
        mortonm@chromium.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Tue, 20 Oct 2020 16:45:49 -0400
In-Reply-To: <20201019173653.527-1-trix@redhat.com>
References: <20201019173653.527-1-trix@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-20_12:2020-10-20,2020-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=793 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200135
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-10-19 at 10:36 -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a return
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Recently "fall through" comments were added before any case statement
without a preceeding break.  Have you made sure these changes won't be
flagged.   Assuming you have,

Acked-by: Mimi Zohar <zohar@linux.ibm.com>

Mimi

