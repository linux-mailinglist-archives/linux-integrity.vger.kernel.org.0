Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2372F7C18
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 14:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbhAONJP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 08:09:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732697AbhAONJN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 08:09:13 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10FD4XRt124176;
        Fri, 15 Jan 2021 08:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=llJi/OMxHgn3H9Db7HWf4+KNzFiqFCWEBYm3DrO1KZ8=;
 b=T2pgB+3ox1sTrn+4EPHbnVLShUJT7Z8S0dwBAul4yh1ZaeAJoqXYNp8GBBCaj5sQJnR3
 xXE4I/e+GKzIGTlvtWJkWRZ/Z5v6YDM1r+bfsYheuFqegqTH4UBNR1vCpefIkZuzAP/h
 4TPgKCEUdl16vdVlqsD+q73MemzRAOOWxxHYvy9nD2kWxtYPMJZ158mUeyFW6LgpXcJy
 dboaMvfe9PA+r4moTHQw1RRqxdx+1Xotxqjwp93VyoUk+ExmA6m0YsQXzsmHTnToEQq/
 nmA1/qGSmXa/71TfE6JWo1yJk/9PqbsP3DQDsbm9JgayUpOUz8K9HRThqXtWpeWDBQAF Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 363af5t65b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 08:08:01 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10FD5A5s127151;
        Fri, 15 Jan 2021 08:07:23 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 363af5t5gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 08:07:23 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10FD6Wae005060;
        Fri, 15 Jan 2021 13:07:04 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 35y448fr3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 13:07:04 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10FD71Ai35848662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 13:07:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AEC64C04E;
        Fri, 15 Jan 2021 13:07:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56C6E4C046;
        Fri, 15 Jan 2021 13:06:58 +0000 (GMT)
Received: from sig-9-65-220-78.ibm.com (unknown [9.65.220.78])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Jan 2021 13:06:58 +0000 (GMT)
Message-ID: <e1c072eba237e75fc687e9318f65e7395e2ca00b.camel@linux.ibm.com>
Subject: Re: [PATCH v3 09/10] certs: Allow root user to append signed hashes
 to the blacklist keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Fri, 15 Jan 2021 08:06:57 -0500
In-Reply-To: <20210114151909.2344974-10-mic@digikod.net>
References: <20210114151909.2344974-1-mic@digikod.net>
         <20210114151909.2344974-10-mic@digikod.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-15_07:2021-01-15,2021-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 mlxlogscore=834 lowpriorityscore=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150077
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mickaël,

On Thu, 2021-01-14 at 16:19 +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Add a kernel option SYSTEM_BLACKLIST_AUTH_UPDATE to enable the root user
> to dynamically add new keys to the blacklist keyring.  This enables to
> invalidate new certificates, either from being loaded in a keyring, or
> from being trusted in a PKCS#7 certificate chain.  This also enables to
> add new file hashes to be denied by the integrity infrastructure.
> 
> Being able to untrust a certificate which could have normaly been
> trusted is a sensitive operation.  This is why adding new hashes to the
> blacklist keyring is only allowed when these hashes are signed and
> vouched by the builtin trusted keyring.  A blacklist hash is stored as a
> key description.  The PKCS#7 signature of this description must be
> provided as the key payload.
> 
> Marking a certificate as untrusted should be enforced while the system
> is running.  It is then forbiden to remove such blacklist keys.
> 
> Update blacklist keyring and blacklist key access rights:
> * allows the root user to search for a specific blacklisted hash, which
>   make sense because the descriptions are already viewable;
> * forbids key update;
> * restricts kernel rights on the blacklist keyring to align with the
>   root user rights.
> 
> See the help in tools/certs/print-cert-tbs-hash.sh provided by a
> following commit.

The design looks good.  I'm hoping to review/test at least this patch
next week.

thanks,

Mimi

