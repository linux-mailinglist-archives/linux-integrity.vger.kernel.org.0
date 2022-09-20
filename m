Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1155BE93B
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Sep 2022 16:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiITOn2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Sep 2022 10:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiITOn1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Sep 2022 10:43:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592DB543ED;
        Tue, 20 Sep 2022 07:43:24 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KEOIvP001224;
        Tue, 20 Sep 2022 14:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UxVWtk+vZQFGZZ3+67pF5QdWkWkUrn5IFrJKkb9HUqo=;
 b=JcLu0jI48+VNvAL8JGyWE5EdHGC0+b8tTz43Fm1cheRHGziadNW2NzDOnZx0mhtxcBL+
 mL2KRnkBGwbl7f+VKQagFqbYD3+1Yp7dVX03YPby5dDYvCBNehnIXUXFoPTDQ/YSqzEz
 ekkueS7vXqL9Ek1qLeBANovOS56AA2sNNYuC9ekFwPnT1oupfurTVuSJ1My8cvaLuHys
 kAfVIy9OpR99GIxUDrz/1LAGTg/qXmn03b21av3GqXOnmmk5i119j+L8QKvT1e7XMuBk
 ZeZqswHkMOd7yZNWVlYL54KvyZPEptXrR6GmeI03BUUMAaRYR6ysInvhTs/1LoPrHjje iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqf8cs0dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 14:43:18 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28KEPsp6013403;
        Tue, 20 Sep 2022 14:43:17 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqf8cs0cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 14:43:17 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28KEaW1e010462;
        Tue, 20 Sep 2022 14:43:17 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 3jn5v9ccej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 14:43:17 +0000
Received: from smtpav05.wdc07v.mail.ibm.com ([9.208.128.117])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28KEhGbw2753164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 14:43:16 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9C6C5806A;
        Tue, 20 Sep 2022 14:43:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D821058068;
        Tue, 20 Sep 2022 14:43:14 +0000 (GMT)
Received: from sig-9-65-239-114.ibm.com (unknown [9.65.239.114])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 20 Sep 2022 14:43:14 +0000 (GMT)
Message-ID: <53730789a41358673b1715dd650706e9ffcb1199.camel@linux.ibm.com>
Subject: Re: [PATCH] KEYS: encrypted: fix key instantiation with
 user-provided data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nikolaus Voss <nv@vosn.de>, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yael Tzur <yaelt@google.com>
Date:   Tue, 20 Sep 2022 10:43:14 -0400
In-Reply-To: <20220919072317.E41421357@mail.steuer-voss.de>
References: <20220919072317.E41421357@mail.steuer-voss.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IweWCdNPe2U8onAHVTg1FmXuToYThrt3
X-Proofpoint-GUID: cuoqxYLGygyiqdGLzzicL6GDQzE22jni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-09-16 at 07:45 +0200, Nikolaus Voss wrote:
> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
> decrypted data") added key instantiation with user provided decrypted data.
> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
> Fix this to use hex2bin instead.

Thanks, Nikolaus.  We iterated a number of times over what would be the
safest userspace input.  One of the last changes was that the key data
should be hex-ascii-encoded.  Unfortunately, the LTP
testcases/kernel/syscalls/keyctl09.c example isn't hex-ascii-encoded
and the example in Documentation/security/keys/trusted-encrypted.rst
just cat's a file.  Both expect the length to be the length of the
userspace provided data.   With this patch, when hex2bin() fails, there
is no explanation.

-- 
thanks,

Mimi

