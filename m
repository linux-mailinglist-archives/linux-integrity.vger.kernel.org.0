Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377D653689A
	for <lists+linux-integrity@lfdr.de>; Fri, 27 May 2022 23:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiE0Vhv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 May 2022 17:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354787AbiE0Vhu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 May 2022 17:37:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C6C1D31D;
        Fri, 27 May 2022 14:37:49 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RJsQe0004938;
        Fri, 27 May 2022 21:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type; s=pp1; bh=4qVUQZ971GoqFZHBxjYEnkAjuJBHMZhmstgrBNOV0g4=;
 b=URmSfWEdPWxrcKeyuyY4OpnvpsJWjH7Pzpa1sKYIsM9Z029AjjnEtrhz1nQlxelzPpOE
 Gewz87C8TfBfh22tlMaM0mJzf3XGuJmHQzxfy9X/l7e2wsbjpINsdput/CJlXH6i7bGB
 Nolmm9pCJ5xwej2+uAtrTSgEcjRS9RPN8ZnzeXFk5LHR8bXsVV0ACvhRNO/RCm3HlXT2
 giSJv5tE2Uufmaxhm6F0wg8Xj2tO8QcfmNkIAC2hcQIveatSgbXUABjypVdAOfBJIQ7o
 rkYIASSgkY7t+fEXtSbXBZ18h4jjniAHN1shISi+lpIIWBjK8Olu07BWDox2aZSpFCp6 ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gb57c1f6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 21:37:44 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24RLXeTM013262;
        Fri, 27 May 2022 21:37:43 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gb57c1f6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 21:37:43 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24RLZDAd028849;
        Fri, 27 May 2022 21:37:43 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04wdc.us.ibm.com with ESMTP id 3gaenbr7bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 21:37:43 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24RLbg6q19136994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 21:37:42 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63BB5C6057;
        Fri, 27 May 2022 21:37:42 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 965AAC6055;
        Fri, 27 May 2022 21:37:41 +0000 (GMT)
Received: from [9.163.6.199] (unknown [9.163.6.199])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 27 May 2022 21:37:41 +0000 (GMT)
Message-ID: <63d645b0-4385-cd1a-6fab-6e17bf01f08b@linux.ibm.com>
Date:   Fri, 27 May 2022 17:37:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] tpm: sleep at least <...> ms in tpm_msleep()
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Holland <johannes.holland@infineon.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
References: <20220510112902.23213-1-johannes.holland@infineon.com>
 <YnvTSqRgYkWu0qgp@kernel.org>
 <99541f08e8b554dea59334005cafb0af978f9a05.camel@linux.ibm.com>
 <eb9ef8aeab4c0284028c013a2c86b248719a46ae.camel@HansenPartnership.com>
 <YoKQchfJ//FUws7i@kernel.org>
 <e5327191-50c5-85b5-6c01-3f43cffc142b@linux.vnet.ibm.com>
 <6df9f7af232bbe10a570e426c2bef0e673ab63fe.camel@HansenPartnership.com>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <6df9f7af232bbe10a570e426c2bef0e673ab63fe.camel@HansenPartnership.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050107080400080209050505"
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q3zqVhdzDaqUNO8dUD-xRPB0ZmZCSR3r
X-Proofpoint-ORIG-GUID: kCZQ6jlAAfTss3B0VkrmDF-bdu7kpZUw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_07,2022-05-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205270104
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050107080400080209050505
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/2022 4:21 PM, James Bottomley wrote:
> Actually, this is nothing to do with the TIMEOUTS_A-D: those are the
> maximum times before a command should complete.  This is the minimum
> time we should wait between pokes of the TPM to see if it is ready.
> Usually the use case is:
> 
> while (read device status gives not ready)
>     tpm_msleep(something)
> 
> The tpm_msleep gives up CPU control (to prevent huge amounts of busy
> waiting) but before 424eaf910c32 ("tpm: reduce polling time to usecs
> for even finer granularity") we would sleep for an entire tick (time
> taken to make the process runnable) before the next poll, and since
> most TPM commands don't return immediately, that was a gate on how fast
> you could do simple TPM operations (like PCR extend).
> 
> As far as I know, no TCG spec gives any details of the minimum wait
> time between poll cycles, so this is really something the manufacturer
> has to tell us.
> 
> Just for completeness, my soak test did run to completion, but my TPM
> has since failed and dropped off the bus, so simply reverting this
> patch (5ef924d9e2e8) isn't sufficient to fully fix my problem.

[FYI]

The TPM vendors explained that polling interrupts TPM command
processing. This will make commands take longer.

They recommend adaptive sleep time based on (at least) the
command.  E.g., getcapability, pcrread, ... are fast so a short
sleep is appropriate.  create, createprimary are slow so
a longer sleep will have better performance.

--------------ms050107080400080209050505
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
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBe
LLAGq3EDXaRbRjTikYn/MA0GCWCGSAFlAwQCAQUAoIICLTAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjA1MjcyMTM3NDFaMC8GCSqGSIb3DQEJBDEiBCD9
9tWlxx1f0vFVBpUfzYTURYQfshRyjh0enQh4R75tIjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGnBgkrBgEEAYI3EAQxgZkwgZYw
gYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQHDBBQb250ZSBTYW4g
UGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0YWxpcyBDbGll
bnQgQXV0aGVudGljYXRpb24gQ0EgRzMCEF4ssAarcQNdpFtGNOKRif8wgakGCyqGSIb3DQEJ
EAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQ
UG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBeLLAGq3EDXaRbRjTikYn/MA0G
CSqGSIb3DQEBAQUABIIBACnodQwFvTjq9pPwh88o20Njss2CImB91wpRh6EaQQ2SVulGPUXV
Ot+2GLOWr0DYWAqjgbK905pI1GPMP7lTakHfkEEcUtc1YU25AM5zw0EUlwAb6SoLO8Awm0CF
Da5gWyXQxwHt5kJP9KdmBkdxlRucPrrZ+AR7HOLzonc6AV/Stdty3Ni9qTCwpe+XwvcNsVb9
qYQ0E8l1U6znt+BiKlgf9YxSi0NuI53jXJqgH7nQIUjMblvT6nr0VuI8XDr93jdBeIyZ6RTD
eVTxXc3g8vW1NX5YL2Z2PT/+rrm76cF5Wim2vhi2l47BMkcAJiheE6frWgwFl5mCUE/NBJAF
rmQAAAAAAAA=
--------------ms050107080400080209050505--

