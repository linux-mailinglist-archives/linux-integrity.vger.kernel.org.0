Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE9447BF58
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Dec 2021 13:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbhLUMGN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Dec 2021 07:06:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231465AbhLUMGM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Dec 2021 07:06:12 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLBUa3H003298;
        Tue, 21 Dec 2021 12:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/NmlB8WtA95C16z+XV5kpgZwtnKCGF+0mPiPBFfVRxs=;
 b=sRl0Rmezc7TIPGFmxgK7vey3dtw3i5Zg0h381mC7LcFw5+DWiF5v/TLOCXKsdtiy3xCE
 z3fPXsVkIQrUO/N0Agd/4pLqF6KTMdFMM5HkrMbp39A36FUlR2/1Rhpn+n4yRgXYjwcR
 h7hQ/kSbBsZ4haZJR25nORcW+CEgOHx4t2m9NvA7U+b6xHtF9xGZUo+JTwGQWPYPH4ZL
 gqQLUEZP/fa4Q5LF4dRqTjA+IHPqVRm6I/1eEtzajGWOERA3lcOBo7eoYi2l0ivfYHd+
 mKFQ5uaZemjMjM8EZQ2M+IZ8f1dPoYmNs2gp4lWqkslgLpKUgi63xzIZTDYS/G2sBgkV xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d1s7quf3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 12:06:00 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BLC0mpi006648;
        Tue, 21 Dec 2021 12:06:00 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d1s7quf39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 12:05:59 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BLBxhBQ016872;
        Tue, 21 Dec 2021 12:05:57 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3d16wjv4h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 12:05:57 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BLC5tig37028314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 12:05:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BE49AE057;
        Tue, 21 Dec 2021 12:05:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91F6CAE055;
        Tue, 21 Dec 2021 12:05:53 +0000 (GMT)
Received: from sig-9-65-69-22.ibm.com (unknown [9.65.69.22])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Dec 2021 12:05:53 +0000 (GMT)
Message-ID: <58e2dbed22d07b9bc381554ada2f14ae655a2f31.camel@linux.ibm.com>
Subject: Re: [PATCH v2] Instantiate key with user-provided decrypted data.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Yael Tiomkin <yaelt@google.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        corbet@lwn.net, dhowells@redhat.com, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 21 Dec 2021 07:05:53 -0500
In-Reply-To: <YcGQMScGMvBd+0+L@iki.fi>
References: <20211213192030.125091-1-yaelt@google.com>
         <YcGQMScGMvBd+0+L@iki.fi>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vQYBL5cME9gL9Q8-6eWJduBHOUA9Jm0T
X-Proofpoint-ORIG-GUID: 1lKwsPkWtbvgERbfllU33Gh2f7d5OrRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_04,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 mlxlogscore=946 priorityscore=1501 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210054
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-12-21 at 10:28 +0200, Jarkko Sakkinen wrote:
> On Mon, Dec 13, 2021 at 02:20:30PM -0500, Yael Tiomkin wrote:
> > The encrypted.c class supports instantiation of encrypted keys with
> 
> What is "the encrypted.c class"?

This is the other key type as described in
Documentation/security/keys/trusted-encrypted.rst, which is not
dependent on a TPM.  This patch adds support for userspace provided key
data, when the key is created.

thanks,

Mimi

