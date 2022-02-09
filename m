Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BD74AE8FB
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Feb 2022 06:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiBIFQd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Feb 2022 00:16:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiBIEqF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Feb 2022 23:46:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBB3C061578;
        Tue,  8 Feb 2022 20:46:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JtnQ60Fbjz4xNq;
        Wed,  9 Feb 2022 15:46:06 +1100 (AEDT)
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
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:
> On Tue, Jan 11, 2022 at 12:37:42PM +0100, Michal Suchanek wrote:
>> Hello,
>> 
>> This is a refresh of the KEXEC_SIG series.
>> 
>> This adds KEXEC_SIG support on powerpc and deduplicates the code dealing
>> with appended signatures in the kernel.
>> 
>> powerpc supports IMA_KEXEC but that's an exception rather than the norm.
>> On the other hand, KEXEC_SIG is portable across platforms.
>> 
>> For distributions to have uniform security features across platforms one
>> option should be used on all platforms.
>> 
>> Thanks
>> 
>> Michal
>> 
>> Previous revision: https://lore.kernel.org/linuxppc-dev/cover.1637862358.git.msuchanek@suse.de/
>> Patched kernel tree: https://github.com/hramrach/kernel/tree/kexec_sig
>> 
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
