Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0384B0D2E
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Feb 2022 13:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241409AbiBJMFu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Feb 2022 07:05:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbiBJMFt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Feb 2022 07:05:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17EC111E;
        Thu, 10 Feb 2022 04:05:50 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21ABpfKN031976;
        Thu, 10 Feb 2022 12:04:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e4cb7cmjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 12:04:01 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21ABJLH1031188;
        Thu, 10 Feb 2022 12:04:00 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e4cb7cmhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 12:04:00 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21ABhrWj022206;
        Thu, 10 Feb 2022 12:03:58 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3e1gvanq1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 12:03:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21AC3r4o45875476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 12:03:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02035A4054;
        Thu, 10 Feb 2022 12:03:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3E4AA405C;
        Thu, 10 Feb 2022 12:03:48 +0000 (GMT)
Received: from sig-9-65-78-200.ibm.com (unknown [9.65.78.200])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Feb 2022 12:03:48 +0000 (GMT)
Received: from ltcimap1.rchland.ibm.com ([unix socket]) by
 ltcimap1.rchland.ibm.com (Cyrus v2.4.17-Fedora-RPM-2.4.17-15.el7) with
 LMTPA; Tue, 08 Feb 2022 22:46:15 -0600
X-Sieve: CMU Sieve 2.4
Received: from localhost (localhost.localdomain [127.0.0.1])
        by ltcimap1.rchland.ibm.com (Postfix) with ESMTP id 702B57200D45;
        Tue,  8 Feb 2022 22:46:15 -0600 (CST)
X-Virus-Scanned: amavisd-new at linux.ibm.com
X-Spam-Score: -0.109
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
Received: from ltcimap1.rchland.ibm.com ([127.0.0.1]) by localhost
 (ltcimap1.rchland.ibm.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id RYcC9RZqfe6t; Tue,  8 Feb 2022 22:46:13 -0600 (CST)
Received: from ltcmx2.rchland.ibm.com (ltcmx2.rchland.ibm.com
 [9.10.229.81]) by ltcimap1.rchland.ibm.com (Postfix) with ESMTP id
 C4ED17200D26; Tue,  8 Feb 2022 22:46:13 -0600 (CST)
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ltcmx2.rchland.ibm.com (Postfix) with ESMTP id 44D05367;
 Tue,  8 Feb 2022 22:46:12 -0600 (CST)
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110]) by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0)
 with ESMTP id 2194kBIu40239504 (version=TLSv1/SSLv3
 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK); Wed, 9 Feb 2022
 04:46:12 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA0DFAE05F;
        Wed,  9 Feb 2022 04:46:11 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C35E1AE060;
        Wed,  9 Feb 2022 04:46:11 +0000 (GMT)
Received: from ppma02dal.us.ibm.com (unknown [9.209.225.56])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed,  9 Feb 2022 04:46:11 +0000 (GMT)
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2194inRK013937;
        Wed, 9 Feb 2022 04:46:11 GMT
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5]) by ppma02dal.us.ibm.com with ESMTP id 3e3gpyv9uc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Feb 2022 04:46:11 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1]) by
 mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2190oaBg007118;
 Wed, 9 Feb 2022 04:46:10 GMT
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3yq2gcq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 04:46:10 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1]) (using
 TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange
 ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) by mail.ozlabs.org (Postfix) with ESMTPSA
 id 4JtnQ60Fbjz4xNq; Wed,  9 Feb 2022 15:46:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1644381966;
        bh=4LBu3b4sqV42JJCmT2RvLfUf47/jOabbpGeO17DWNxg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VpsRKjTOAuTL4YVFAXqLwlQNTVN2PnFaRNMaDdmekioS+Axih9wqxwuuZXvgF38GV
         BtlQrTRz2IAQ9QmpujmvPxeEPJBOCKQODVTttnlXUqTA3LNbZRxgAs7FMDYFW7UAzp
         hNZMjJnJRRBuEQsm/scDVGFl3F1CnxD/UQBFK7HXqfl2FNQM9xzVfhzm6vaSQz1Oui
         eoQoylhJFl+fMdpPBEWkx0gW9z1nkkfG9Ee4wjyAlpTXz2FASBp3lrsVq34UIp87iV
         WiyxUBkfMXtIWN/O5RXzGc5uFFcCQQWtagfWwXYs+Xzz/Ci/ixvZSY69tgrW3wLzm6
         VxO4WOGIITJUw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Michal Suchanek <msuchanek@suse.de>,
        David Howells <dhowells@redhat.com>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 0/6] KEXEC_SIG with appended signature
In-Reply-To: <YfBd/EDGUx9UIHcb@bombadil.infradead.org>
References: <cover.1641900831.git.msuchanek@suse.de>
 <YfBd/EDGUx9UIHcb@bombadil.infradead.org>
Date:   Wed, 09 Feb 2022 15:46:05 +1100
Message-ID: <87pmnwlkaa.fsf@mpe.ellerman.id.au>
Content-Type: text/plain
X-Proofpoint-Banner-Trigger: inbound
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_01,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=inbound_notspam policy=inbound score=0
 priorityscore=0 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=266 lowpriorityscore=0 mlxlogscore=811
 impostorscore=0 bulkscore=0 classifier=spam adjust=-480 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202090033
X-TM-AS-GCONF: 00
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-Proofpoint-ORIG-GUID: sgISM_EWnI_noxew-AAhi8REcIgE3pOK
X-Proofpoint-GUID: fs62dQ07YCVy2FuRhMfUGIrBPvbAxd8l
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_05,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=902 phishscore=0 impostorscore=0
 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1034
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100066
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:
> On Tue, Jan 11, 2022 at 12:37:42PM +0100, Michal Suchanek wrote:
>> Hello,
>>=20
>> This is a refresh of the KEXEC_SIG series.
>>=20
>> This adds KEXEC_SIG support on powerpc and deduplicates the code dealing
>> with appended signatures in the kernel.
>>=20
>> powerpc supports IMA_KEXEC but that's an exception rather than the norm.
>> On the other hand, KEXEC_SIG is portable across platforms.
>>=20
>> For distributions to have uniform security features across platforms one
>> option should be used on all platforms.
>>=20
>> Thanks
>>=20
>> Michal
>>=20
>> Previous revision: https://lore.kernel.org/linuxppc-dev/cover.1637862358=
.git.msuchanek@suse.de/
>> Patched kernel tree: https://github.com/hramrach/kernel/tree/kexec_sig
>>=20
>> Michal Suchanek (6):
>>   s390/kexec_file: Don't opencode appended signature check.
>>   powerpc/kexec_file: Add KEXEC_SIG support.
>>   kexec_file: Don't opencode appended signature verification.
>>   module: strip the signature marker in the verification function.
>>   module: Use key_being_used_for for log messages in
>>     verify_appended_signature
>>   module: Move duplicate mod_check_sig users code to mod_parse_sig
>
> What tree should this go through? I'd prefer if over through modules
> tree as it can give a chance for Aaron Tomlin to work with this for his
> code refactoring of kernel/module*.c to kernel/module/

Yeah that's fine by me, the arch changes are pretty minimal and unlikely
to conflict much.

cheers

