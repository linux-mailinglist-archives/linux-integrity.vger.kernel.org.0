Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D021218ECD3
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Mar 2020 23:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCVWK4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 Mar 2020 18:10:56 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:48178 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCVWKz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Mar 2020 18:10:55 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8EA4472CCE7;
        Mon, 23 Mar 2020 01:10:52 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 7CF204A4AE7;
        Mon, 23 Mar 2020 01:10:52 +0300 (MSK)
Date:   Mon, 23 Mar 2020 01:10:51 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7] ima-evm-utils: Add some tests for evmctl
Message-ID: <20200322221051.nrbh2nukxenqinwj@altlinux.org>
Mail-Followup-To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190817233348.22349-1-vt@altlinux.org>
 <392fed51-095d-2a6f-5eda-317e3bbc8707@linux.microsoft.com>
 <20200319154957.ijh7tbfp4d7iwcef@altlinux.org>
 <a8b77ade-58bf-88ac-542b-b8fbdd651db4@linux.microsoft.com>
 <62502cc8-c861-0227-cdce-4bbea6b05f3e@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <62502cc8-c861-0227-cdce-4bbea6b05f3e@linux.microsoft.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Lakshmi,

On Thu, Mar 19, 2020 at 02:57:22PM -0700, Lakshmi Ramasubramanian wrote:
> 
> When I run the tests, all ima_hash tests pass.
> But most of sign_verify tests fail.

Please tell what version of ima-evm-utils you are using (what is head
commit id).

> I am not sure if I am missing anything in the test setup. Please let me
> know.
> 
> In the file sign_verify.test, I commented out all the tests except the
> following:
> 
> 	sign_verify  rsa1024  sha1    0x0301 --rsa
> 
> The text file sha1.txt created by the test is signed fine. But the signature
> verification fails.
> 
> Please see the log at the end of the mail for more detail.
> 
> evmctl fails to decode the key file when using the public key
> "test-rsa1024.pub"
> 
> evmctl -v ima_verify --key test-rsa1024.pub --xattr-user --rsa sha1.txt
> >>> Failed to d2i_X509_fp key file: test-rsa1024.pub

Please show me content of your test-rsa1024.key and test-rsa1024.pub,
and `getfattr -dm. sha1.txt`.

Thanks,


> 
> But if I pass the certificate file, the file is decoded fine, but signature
> verification fails.
> 
> evmctl -v ima_verify --key test-rsa1024.cer --xattr-user --rsa sha1.txt
> >>> key 1: d33cbeb0 test-rsa1024.cer
> 
> Test log
> --------
> evmctl is ../src/evmctl
> openssl is /usr/bin/openssl
> xxd is /usr/bin/xxd
> getfattr is /usr/bin/getfattr
> - openssl dgst -sha1 sha1.txt
> - openssl dgst -sha1 -sign test-rsa1024.key -hex sha1.txt
> + evmctl -v ima_sign --rsa --sigfile --hashalgo sha1 --key test-rsa1024.key
> --xattr-user sha1.txt
>   hash(sha1): da39a3ee5e6b4b0d3255bfef95601890afd80709
>   sighash: 52d14dacbdb7e7b4195f302357f2324aba026af5
>   evm/ima signature-v1: 146 bytes
>   Writing to sha1.txt.sig
> 
> 030130ca735e0000502a83d5a17c171e01040034d161431091513a700f0f9c92c43aee09b59e48a66123afcc4fc8ca6ab9993aa61df9a5d3e38fdaed2e091c6c24b85a3418c1229417d4f3aedb230fd018e7658a6b785de56d3f8e5c029601d77b303f9100b547b5db4adf7e53877874d807811d47eac9ecefcebe6bd5ef49e345671ac87b5fb27e51ea8565dd19a4b93a4a80
> + evmctl -v ima_verify --key test-rsa1024.pub --xattr-user --rsa sha1.txt
> 
> evmctl ima_verify failed with (1)
>   Failed to d2i_X509_fp key file: test-rsa1024.pub
>   openssl: error:0D0680A8:asn1 encoding routines:asn1_check_tlen:wrong tag
>   openssl: error:0D07803A:asn1 encoding routines:asn1_item_embed_d2i:nested
> asn1 error
>   hash-v1: da39a3ee5e6b4b0d3255bfef95601890afd80709
> 
> thanks,
>  -lakshmi
