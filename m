Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2907F1FD9A9
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 01:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgFQXee (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 19:34:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:32849 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbgFQXee (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 19:34:34 -0400
IronPort-SDR: pSyWQ575dzFsEX6Rbcz9iwm9W8a1iLWrt27041SqqiM5G8WB7cHEQYu7juDJzGNcfCAGDz8S43
 x+HHYfb2WXrg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 16:34:33 -0700
IronPort-SDR: b8XaHKzog4e0cvRNrkGKMiKCMnllOA5N3Fc5k1sOedh0t/BirR8y3BOEPYgDxerIOVxo4jmp82
 MGw6IOBAkDXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="317669513"
Received: from kleeve-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.166])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jun 2020 16:34:30 -0700
Date:   Thu, 18 Jun 2020 02:34:29 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Stalled /dev/tpmr0 when context size increases to support RSA
 3072 bit keys
Message-ID: <20200617233429.GH62794@linux.intel.com>
References: <b404211d-f540-d2bd-eaf6-2b616bebb899@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b404211d-f540-d2bd-eaf6-2b616bebb899@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 16, 2020 at 06:30:24PM -0400, Stefan Berger wrote:
> I am upgrading libtpms's TPM 2 to support RSA 3072 keys (increase context
> size to 2680 bytes) and wanted to test an upgrade from previous version
> (0.7.2) which only supports RSA 2048 keys to this newer version (git
> master). I tried to run this with clevis setting up automatic decryption via
> TPM 2, but it doesn't work and it seems the issue is due to a stall of
> /dev/tpmr0 that doesn't respond anymore.
> 
> 
> So here's a simple sequence with added 'set -x' into clevis-encrypt-tpm2 and
> clevis-decrypt-tpm2:
> 
> All good in the encryption part:
> 
> [root@localhost ~]# echo hi | clevis encrypt tpm2 '{"key":"rsa"}' >
> hi-rsa3072.jwe
> + case "$TPM2TOOLS_VERSION" in
> + tpm2_createprimary -Q -C o -g sha256 -G rsa -c
> /tmp/tmp.cqg0DMjuL4/primary.context
> + set +x
> + case "$TPM2TOOLS_VERSION" in
> + tpm2_create -Q -g sha256 -C /tmp/tmp.cqg0DMjuL4/primary.context -u
> /tmp/tmp.cqg0DMjuL4/jwk.pub -r /tmp/tmp.cqg0DMjuL4/jwk.priv -a
> 'fixedtpm|fixedparent|noda|adminwithpolicy|userwithauth' -i-
> + set +x
> 
> The decryption part stalls:
> 
> [root@localhost ~]# clevis decrypt < hi-rsa3072.jwe 2>&1 | tee strace.log
> + case "$TPM2TOOLS_VERSION" in
> + tpm2_createprimary -Q -C o -g sha256 -G rsa -c
> /tmp/tmp.9W2U5Fw8HX/primary.context
> + set +x
> + case "$TPM2TOOLS_VERSION" in
> + tpm2_load -Q -C /tmp/tmp.9W2U5Fw8HX/primary.context -u
> /tmp/tmp.9W2U5Fw8HX/jwk.pub -r /tmp/tmp.9W2U5Fw8HX/jwk.priv -c
> /tmp/tmp.9W2U5Fw8HX/load.context -V
> INFO on line: "362" in file: "lib/files.c": Assuming tpm context file
> INFO on line: "293" in file: "lib/files.c": load: TPMS_CONTEXT->savedHandle:
> 0x80000000
> ^Z
> [1]+  Stopped                 clevis decrypt < hi-rsa3072.jwe 2>&1 | tee
> strace.log
> 
> 
> Note: I put the tool in the background using ctrl-Z and now I can run this
> stalled command and it works!
> 
> [root@localhost ~]# tpm2_load -Q -C /tmp/tmp.9W2U5Fw8HX/primary.context -u
> /tmp/tmp.9W2U5Fw8HX/jwk.pub -r /tmp/tmp.9W2U5Fw8HX/jwk.priv -c load.context
> -V
> INFO on line: "362" in file: "lib/files.c": Assuming tpm context file
> INFO on line: "293" in file: "lib/files.c": load: TPMS_CONTEXT->savedHandle:
> 0x80000000
> INFO on line: "190" in file: "lib/files.c": Save TPMS_CONTEXT->savedHandle:
> 0x80000000
> 
> 
> I know that the above is stalled because I had strace'd it:
> 
> openat(AT_FDCWD, "/dev/tpmrm0", O_RDWR|O_NONBLOCK) = 3
> 
> [...]
> 
> write(3, "\200\1\0\0\0;\0\0\1v@\0\0\7@\0\0\7\0
> \316)s\332fV_\177\326\303\221#"..., 59) = 59
> poll([{fd=3, events=POLLIN}], 1, -1)    = 1 ([{fd=3, revents=POLLIN}])
> read(3, "\200\1\0\0\0000\0\0\0\0\2\0\0\0\0
> \303cQ\225\0\235F\4-\225:y\353\254\220\247"..., 4096) = 48
> openat(AT_FDCWD, "/tmp/tmp.9WItRVOByv/primary.context", O_RDONLY) = 4
> fstat(4, {st_mode=S_IFREG|0644, st_size=3036, ...}) = 0
> brk(NULL)                               = 0x55fc8d415000
> brk(0x55fc8d436000)                     = 0x55fc8d436000
> read(4, "\272\334\300\336\0\0\0\1@\0\0\1\200\0\0\0\0\0\0\0\0\0\0B\v\302\0\0\0\0\nr"...,
> 4096) = 3036
> lseek(4, -3036, SEEK_CUR)               = 0
> write(2, "INFO on line: \"362\" in file: \"li"..., 44INFO on line: "362" in
> file: "lib/files.c": ) = 44
> write(2, "Assuming tpm context file", 25Assuming tpm context file) = 25
> write(2, "\n", 1
> )                       = 1
> read(4, "\272\334\300\336\0\0\0\1@\0\0\1\200\0\0\0\0\0\0\0\0\0\0B\v\302\0\0\0\0\nr"...,
> 4096) = 3036
> write(2, "INFO on line: \"293\" in file: \"li"..., 44INFO on line: "293" in
> file: "lib/files.c": ) = 44
> write(2, "load: TPMS_CONTEXT->savedHandle:"..., 43load:
> TPMS_CONTEXT->savedHandle: 0x80000000) = 43
> write(2, "\n", 1
> )                       = 1
> write(3,
> "\200\1\0\0\n\216\0\0\1a\0\0\0\0\0\0\0B\200\0\0\0@\0\0\1\nr\0@]\234"...,
> 2702) = 2702
> poll([{fd=3, events=POLLIN}], 1, -1)    = 1 ([{fd=3, revents=POLLIN}])
> read(3, "\200\1\0\0\0\16\0\0\0\0\200\377\377\377", 4096) = 14
> close(4)                                = 0
> getpid()                                = 1591
> getpid()                                = 1591
> write(3, "\200\2\0\0\1{\0\0\1W\200\377\377\377\0\0\0I\2\0\0\0\0
> \203\33\326qO\214\r\0"..., 379) = 379
> poll([{fd=3, events=POLLIN}], 1, -1
> 
> It's stuck polling on /dev/tpmrm0.
> 
>    Any ideas?
> 
> 
>     Stefan
> 
> 

Tadeusz,

Could this possibly be something to do with partial reads?

/Jarkko
