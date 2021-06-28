Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED593B6AC8
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 00:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhF1WG6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Jun 2021 18:06:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43732 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234255AbhF1WG4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Jun 2021 18:06:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SM3nl3077878;
        Mon, 28 Jun 2021 18:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=pp1; bh=/j/I9RNOSJVzxhIpCwjAFlqFGV/o4jH+HkdfSVk0oRs=;
 b=VHX35BWMKJE46mFBEzeY9NIe272c6E4ctZnMo2aKFyI6Yn3PU4NMqleotH6DSECKuMlY
 uwzjl4XSjXJchssXoThLnD/Sz0Sr4OCkUw0mKP8bLfynwCZeRkFTkb1MluDwhuMC0o2k
 DzW7wcaMQU/kGGSEi/kAbkzhUkN7VgY1oYA8dpIX6a8aMFlg7/F8nWOSU3f0oUKNg1lC
 Q59XMZoZlsE7YoJX3TfyQZ2XL+wdi5UkFJ40uEM1R2G0YXumk6ZMiPOndGPSlVgo3EWc
 lrroMSxPTjt6zV/BbuX9pgyN6n2EPq0fUmWB5T9C68S2vXIrVBne/bSRpG5oXXrsZ0qT lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fm5jbyhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 18:04:24 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15SM4NE6079429;
        Mon, 28 Jun 2021 18:04:24 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fm5jbyhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 18:04:23 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SM2JmB014275;
        Mon, 28 Jun 2021 22:04:23 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 39ekxaknep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 22:04:23 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SM4LrE32440662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 22:04:21 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0A24136074;
        Mon, 28 Jun 2021 22:04:21 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C41421360BD;
        Mon, 28 Jun 2021 22:04:20 +0000 (GMT)
Received: from [9.65.68.196] (unknown [9.65.68.196])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 22:04:20 +0000 (GMT)
Subject: Re: ima - wait for tpm load
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>
References: <20210610071633.GA30216@trex>
 <b3c1f5a0a37419fac51d570cd1c8e521f59cee14.camel@linux.ibm.com>
 <20210610151801.GA19687@trex>
 <f0c6ab70093eb9e360232482ce415e9863a8699c.camel@linux.ibm.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <1341c53c-1aa7-62dc-db9f-b58dcb8b7906@linux.ibm.com>
Date:   Mon, 28 Jun 2021 18:04:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f0c6ab70093eb9e360232482ce415e9863a8699c.camel@linux.ibm.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms080705080204090202070806"
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: txPh4_nK0mImkWhg8ohXwBEDR4iPEaK8
X-Proofpoint-GUID: tY3nhzrRKFuX2nJjQ89ggPMGIIrkYmcW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_14:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106280143
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080705080204090202070806
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/10/2021 4:31 PM, Mimi Zohar wrote:
> As I recall "extend" works pretty much from the beginning.  There's no
> need to wait for the self test to complete.   Registering the TPM early=

> might be enough without having to wait.  Or maybe check the selftest
> result.

TPM 2.0 depends somewhat on the type of self test - there are several
options.  They will in some sense block other commands that use
the angorithm.

The TPM is permitted to do an extend before the hash algorithm is
tested (just not return a result) but I don't think it's required.

So:

- self test
- extend

may permit the extend to proceed while the self test is
happening, but it may not.



--------------ms080705080204090202070806
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
JTNkQWN0YWxpcyUyMFMucC5BLiUyZjAzMzU4NTIwOTY3LGMlM2RJVD9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0O2JpbmFyeTA9oDugOYY3aHR0cDovL2NybDA1LmFjdGFsaXMuaXQvUmVw
b3NpdG9yeS9BVVRILVJPT1QvZ2V0TGFzdENSTDAdBgNVHQ4EFgQUvpepqoS/gL8QU30JMvnh
LjIbz3cwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQAmm+cbWQ10sxID6edV
94SAhc1CwzthHFfHpuYS30gisWUfWpgp43Dg1XzG2in3VGV7XrzCCGZh4JM/XQWp+4oxmyV4
2Qjz9vc8GRksgo6X2nYObPYZzQjda9wxsCB38i4G3H33w8lf9sFvl0xm4ZXZ2s2bF/PdqvrK
0ZgvF51+MoIPnli/wJBw3p72xbk5Sb1MneSO3tZ293WFzDmz7tuGU0PfytYUkG7O6annGqbU
1I6CA6QVKUqeFLPodSODAFqJ3pimKD0vX9MuuSa0QinH7CkiPtZMD0mpwwzIsnSs3qOOl60t
IZQOTc0I6lCe1LLhrz7Q75J6nNL9N5zVwZ1I3o2Lb8Dt7BA13VFuZvZIzapUGV83R7pmSVaj
1Bik1nJ/R393e6mwppsT140KDVLh4Oenywmp2VpBDuEj9RgICAO0sibv8n379LbO7ARa0kw9
y9pggFzN2PAX25b7w0n9m78kpv3z3vW65rs6wl7E8VEHNfv8+cnb81dxN3C51KElz+l31zch
FTurD5HFEpyEhzO/fMS5AkweRJIzwozxNs7OL/S/SVTpJLJL1ukZ1lnHHX0d3xCzRy/5HqfK
3uiG22LPB5+RjNDobPAjAz2BKMfkF/+v0pzn8mqqkopQaJzEAbLbMpgQYHRCjvrUxxwjJyUF
b2Z+40UNtMF4MTK7zTGCA/MwggPvAgEBMIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwH
QmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBT
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBt
lC9msSpKrr0rmsrvlS70MA0GCWCGSAFlAwQCAQUAoIICLTAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA2MjgyMjA0MjBaMC8GCSqGSIb3DQEJBDEiBCAr
mk+Y5ezDx714eoOEdPVRP189hIVXWimQD1Y613kMaTBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGnBgkrBgEEAYI3EAQxgZkwgZYw
gYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQHDBBQb250ZSBTYW4g
UGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0YWxpcyBDbGll
bnQgQXV0aGVudGljYXRpb24gQ0EgRzMCEG2UL2axKkquvSuayu+VLvQwgakGCyqGSIb3DQEJ
EAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQ
UG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBtlC9msSpKrr0rmsrvlS70MA0G
CSqGSIb3DQEBAQUABIIBAFbCpNH0x9gMUO7pWQ3Ca2TNTZfu4k0suoBgESNuBJQR6f5cjBpT
tcJE9t0alwWCUSW4nc5DU3oHm/Rmbk1BFV00C16mXSI/y9ThOB1M9S0NbiWSlylB7cxD2H/p
0Gb+xFYJ8WyrsxN+c6BGKdltjaHyoFJ7pA26sA5fG7/0A9Np0FGTie/ly9AL3VyNbx0pxOGX
QAi9hfNwjUKe+01BeQtOb2EdUhMyFDUSP1nsFNq9yOmpGM44zrJ/x/DkNojQAPw71Te97lW+
YCV0acIz4Bob4CyUwVzBD+L+E4kvUbHsmWGRWLY5olNeif5fE6PwKuf8ddgdmk+sXvnXlcEa
6ZcAAAAAAAA=
--------------ms080705080204090202070806--

