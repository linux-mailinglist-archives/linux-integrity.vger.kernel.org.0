Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A803BC353
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jul 2021 22:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhGEUMk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jul 2021 16:12:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229817AbhGEUMj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jul 2021 16:12:39 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165K2Wpr094107;
        Mon, 5 Jul 2021 16:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=urEcpsOy6/uk99Ov4kWfRZIgE4fOu4kGqjl1GjIFV5M=;
 b=BtSHgMxfOcxzFicRHrMSQpLEt9hAcjRk66zDbkQi9T4RNa4/jqeGRhMC4GXRZ8X4ZAIy
 qHnstWPbTKkEAW0BRqqIeyVnLOOf7vWTpraeNmNPXX47WEuYvAhGAce1rO72GT82NdE0
 lodINM8BmAaj3knOdMFqj2UQDqneboZUQagHYgXGr3gS54UGd/70W7I6EErRS8pxlpt1
 nO9vRYHQGmPzI0Ttt1eDvTa5F1qW76KIPgs1dsxCrKPa1XLWhdWvfvOe79a3yCncpPoA
 DDIQ+3lkOBNZlBke8v9vbmRhL5JxO4sTJs76xgqnzVW97YEVql5I8XdaM3MOOnk0Kd1G +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39m5q14a01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 16:10:00 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 165K2jGm095392;
        Mon, 5 Jul 2021 16:10:00 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39m5q149y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 16:09:59 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 165K0Hug000794;
        Mon, 5 Jul 2021 20:04:57 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 39jfh88gmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 20:04:57 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 165K34q837880290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Jul 2021 20:03:04 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFCC04C04A;
        Mon,  5 Jul 2021 20:04:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A65464C046;
        Mon,  5 Jul 2021 20:04:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.121.224])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Jul 2021 20:04:52 +0000 (GMT)
Message-ID: <f304a136df93bd74e06a68737f9512e003e329ab.camel@linux.ibm.com>
Subject: Re: [PATCH v7 3/3] ima-evm-utils: Read keyid from the cert appended
 to the key file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 05 Jul 2021 16:04:52 -0400
In-Reply-To: <20210701011323.2377251-4-vt@altlinux.org>
References: <20210701011323.2377251-1-vt@altlinux.org>
         <20210701011323.2377251-4-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uzN5B3-rug_O1MDOCb_itJuHDLfAi3By
X-Proofpoint-GUID: 2d76zwFNQb3qZrUzqJVz4Jq_0JeHE_HF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-05_10:2021-07-02,2021-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050107
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Thu, 2021-07-01 at 04:13 +0300, Vitaly Chikunov wrote:
> 
> +/**
> + * read_keyid_from_key() - Read 32-bit keyid from the key file
> + * @keyid_be:   Pointer to 32-bit value in network order (BE, unaligned).
> + * @keyfile:    PEM file with private key with optionally appended x509 cert.
> + * Return:      0 on success and keyid_be is written;
> + *              -1 on error, logged error message, and keyid_be isn't written.
> + */
> +static int read_keyid_from_key(uint32_t *keyid_be, const char *keyfile)

(With  the new option "--keyid-from-cert" is this patch really still
needed?)

The function name is a bit off.  Both imaevm_read_keyid() and this
function are getting the keyid from a cert.  There's also quite a bit
of code duplication between them.  Refactoring the code might help. 
For example, perhaps imaevm_read_keyid() could be a wrapper for
read_keyid_from_cert().

Otherwise renaming this function to read_keyid_from_keyfile(),
read_appended_keyid() or read_appended_keyid_from_cert(), which is
really wordy, would be better.

thanks,

Mimi

