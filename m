Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082C63B4314
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jun 2021 14:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhFYMYl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Jun 2021 08:24:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229498AbhFYMYl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Jun 2021 08:24:41 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PCHK23194433;
        Fri, 25 Jun 2021 08:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=vIItvn+3gmQJ5U1WUFBv3w2doBkpp2XOKhTr3fktIEI=;
 b=Jhmy5vDWlud3ClmBX4jUf4R89maOP/pQsbwA7H7l1Va8GAfaswPQrEKWJVrsEgN0ETo3
 jRL8lfGoc3bF8yNj5PTZZzDV8+KLt6+yJ+9qDZ5546KA71Tkpcy5/+idEe2+qQ2hTH+C
 kBCozWqlI5/CQWnzQ9HApIcTYK81c/1tFJ2j06X8JwmUGygUCNPPNG4yoa2OjnWpf8FO
 +6S5WFnOf3IEGAa15b7ngynhIS5AVgHima8umCQqa1MFOwv5IFnRTnuiv8DQxfI3L5R8
 Cl0r519DpTuryOjXy5yGIWbpyfPB38zjF2LRyLYpTkr23r6iLZhZ6bA83KCh5IV7CPRd vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39dek4h4wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 08:22:18 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15PCHg78195854;
        Fri, 25 Jun 2021 08:22:18 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39dek4h4vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 08:22:18 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15PCEslZ024109;
        Fri, 25 Jun 2021 12:22:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3997uhb141-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 12:22:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15PCMDnX30212368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:22:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D63EB4203F;
        Fri, 25 Jun 2021 12:22:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFC4D42045;
        Fri, 25 Jun 2021 12:22:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.9.226])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Jun 2021 12:22:12 +0000 (GMT)
Message-ID: <ffac9c53bacfc5a0d16ae457289d7c224c8ef924.camel@linux.ibm.com>
Subject: Re: [PATCH v6 2/3] ima-evm-utils: Allow manual setting keyid from a
 cert file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 25 Jun 2021 08:22:06 -0400
In-Reply-To: <20210511115630.795208-3-vt@altlinux.org>
References: <20210511115630.795208-1-vt@altlinux.org>
         <20210511115630.795208-3-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vMqAwikEDjEoU501WcXKus9Z08srx6-n
X-Proofpoint-GUID: Idb77HAMn8yLfXE8eja0XePARibWoKVw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-25_04:2021-06-25,2021-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250069
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-05-11 at 14:56 +0300, Vitaly Chikunov wrote:
> 
> +/**
> + * imaevm_read_keyid() - Read 32-bit keyid from the cert file.
> + * @certfile:	File possibly containing certificate in DER/PEM format.
> + *
> + * Try to read keyid from Subject Key Identifier (SKID) of certificate.
> + * Autodetect if cert is in PEM or DER encoding.
> + *
> + * Return: 0 on error;
> + *         32-bit keyid as unsigned integer in host order.
> + */
> +uint32_t imaevm_read_keyid(const char *certfile)
> +{
> +	uint32_t keyid_raw = 0;
> +
> +	__read_keyid(&keyid_raw, certfile, KEYID_FILE_UNK_CERT);
> +	return ntohl(keyid_raw);

On error, __read_keyid() returns < 0, but the return value isn't
checked before calling ntohl.  In either case, is imaevm_params.keyid
suppose to be big endian byte order?  If so, the call to htonl in
sign_hash_v2() would be unnecessary.

thanks,

Mimi

