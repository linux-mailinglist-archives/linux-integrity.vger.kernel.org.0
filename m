Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBDCE9DAE5
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2019 03:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfH0BFF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Aug 2019 21:05:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726487AbfH0BFF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Aug 2019 21:05:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7R11gCh144808;
        Mon, 26 Aug 2019 21:04:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2umt9qrf5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 21:04:54 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7R11p2Z145462;
        Mon, 26 Aug 2019 21:04:54 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2umt9qrf58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 21:04:54 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7R11Nsm012160;
        Tue, 27 Aug 2019 01:04:53 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 2ujvv7388v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 01:04:53 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7R14qdo51642862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 01:04:52 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7707BE053;
        Tue, 27 Aug 2019 01:04:51 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34129BE059;
        Tue, 27 Aug 2019 01:04:46 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.159.67])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Aug 2019 01:04:45 +0000 (GMT)
References: <20190628021934.4260-1-bauerman@linux.ibm.com> <9682b5d0-1634-2dd0-2cbb-eb1fa8ba7423@linux.microsoft.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Jordan Hand <jorhand@linux.microsoft.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI\, Takahiro" <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v12 00/11] Appended signatures support for IMA appraisal
In-reply-to: <9682b5d0-1634-2dd0-2cbb-eb1fa8ba7423@linux.microsoft.com>
Date:   Mon, 26 Aug 2019 22:04:43 -0300
Message-ID: <87k1azpges.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270008
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hello Jordan,

Jordan Hand <jorhand@linux.microsoft.com> writes:

> On 6/27/19 7:19 PM, Thiago Jung Bauermann wrote:
>> On the OpenPOWER platform, secure boot and trusted boot are being
>> implemented using IMA for taking measurements and verifying signatures.
>> Since the kernel image on Power servers is an ELF binary, kernels are
>> signed using the scripts/sign-file tool and thus use the same signature
>> format as signed kernel modules.
>> 
>> This patch series adds support in IMA for verifying those signatures.
>> It adds flexibility to OpenPOWER secure boot, because it allows it to boot
>> kernels with the signature appended to them as well as kernels where the
>> signature is stored in the IMA extended attribute.
>
> I know this is pretty late, but I just wanted to let you know that I
> tested this patch set on x86_64 with QEMU.
>
> That is, I enrolled a key to _ima keyring, signed my kernel and modules
> with appended signatures (with scripts/sign-file), set the IMA policy to
> appraise and measure my kernel and modules. Also tested kexec appraisal.
>
> You can add my tested-by if you'd like.

Thanks for testing!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
