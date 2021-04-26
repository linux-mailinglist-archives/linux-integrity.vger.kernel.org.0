Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B725036BA9F
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Apr 2021 22:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbhDZUWR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Apr 2021 16:22:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27584 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238112AbhDZUWQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Apr 2021 16:22:16 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QK4CuC101707;
        Mon, 26 Apr 2021 16:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=FdbflOBV1Mes1Ry0lse7fVp7uyda+joSwUjsHq9EmO4=;
 b=siITzap5H354as2hEVZx8/YZTBkYJ1iVl9eA7cUyNAy3Ic5/LfTcxD6/jwLCtixBS4tS
 pIOSmWmH6YCO5jBpN94/kjRpmu755NNdpMpQVeRwTtLktaPry9F4G+OOxQbwOnihZ+2u
 8AmwOPSJ2SaV9LS4wmZWOGVudDCl0R+Zn5kKk4ABJGU6i1xRejmldXqBZjzRO0Jt4q+P
 lLGx14d/ltC4bE9RmSajZFy5McrTQo433C02eZk6GED0u27bIFXHpJy11jpZOoKThRI4
 xeymPnyjaAEE4/5feuCEbQOQWzx8H7DlR92jONA795HfzVl8dmCFfNzf8cMAkjeuh6w3 bg== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3861bb5atx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 16:21:28 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QKHh1R006521;
        Mon, 26 Apr 2021 20:21:28 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 384ay98qh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 20:21:28 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13QKLRMe12583772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 20:21:27 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 336EE2805A;
        Mon, 26 Apr 2021 20:21:27 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24B2C28058;
        Mon, 26 Apr 2021 20:21:27 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 26 Apr 2021 20:21:27 +0000 (GMT)
Subject: Re: calc_keyid_v2 producing different keyid for non-sha1 SKIDs
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
References: <20210426193723.rfar32ft3iptorii@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <738bff9b-5cde-4f06-3e54-4d6eebcf9383@linux.ibm.com>
Date:   Mon, 26 Apr 2021 16:21:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210426193723.rfar32ft3iptorii@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: euiPAU6xJ5CSTFLNudtBsCzN7dVHImr5
X-Proofpoint-GUID: euiPAU6xJ5CSTFLNudtBsCzN7dVHImr5
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_09:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260153
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/26/21 3:37 PM, Vitaly Chikunov wrote:
> Hi,
>
> I am reported that IMA signatures where SKID is not just sha1 of the
> public key (but something different, for example different hash algo,
> such as Streebog) have "wrong" keyid in the signature. This is because
> a) kernel extracting keyid from the cert's subjectKeyIdentifier (SKID)
> x509 extension, (or if this fails it takes just serial, perhaps, we can
> disregard this corner case), it never does sha1 over the public key).


Is it wrong for ecrdsa keys? What is the spec?

Here's the spec that describes using sha1 for the skid which seems to 
work like this for RSA and ECDSA keys from what I can tell:

https://tools.ietf.org/html/rfc3280#section-4.2.1.2


> But, b) evmctl, when signing, uses just private key (not even knowing
> certificate where SKID should be) and calculating sha1 of public key.
> Thus, keyids could mismatch each other, and it's even not easy to fix
> evmctl, because there is no cert at the time of signing.
>
> Perhaps, we should fix this somehow. For example, when signing,
> introduce new option --cert, where SKID should be extracted. Does it
> looks reasonable?
>
> Vitaly,
>
>
>
