Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF0B378E
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 11:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfIPJxj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 05:53:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:52485 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfIPJxj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 05:53:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 02:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="gz'50?scan'50,208,50";a="387149126"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2019 02:53:35 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i9nhP-0003gx-Au; Mon, 16 Sep 2019 17:53:35 +0800
Date:   Mon, 16 Sep 2019 17:52:57 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     kbuild-all@01.org, linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Fix tpm_send() length calculation
Message-ID: <201909161739.iQLjdTiR%lkp@intel.com>
References: <20190916073535.25117-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5yfl4un7vu3iqns5"
Content-Disposition: inline
In-Reply-To: <20190916073535.25117-1-jarkko.sakkinen@linux.intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--5yfl4un7vu3iqns5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jarkko,

I love your patch! Yet something to improve:

[auto build test ERROR on jss-tpmdd/next]
[cannot apply to v5.3 next-20190915]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jarkko-Sakkinen/tpm-Fix-tpm_send-length-calculation/20190916-162814
base:   git://git.infradead.org/users/jjs/linux-tpmdd next
config: x86_64-randconfig-a004-201937 (attached as .config)
compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/char/tpm/tpm-interface.c: In function 'tpm_send':
>> drivers/char/tpm/tpm-interface.c:366:5: error: 'struct tpm_buf' has no member named 'length'
     buf.length = buflen;
        ^

vim +366 drivers/char/tpm/tpm-interface.c

   343	
   344	/**
   345	 * tpm_send - send a TPM command
   346	 * @chip:	a &struct tpm_chip instance, %NULL for the default chip
   347	 * @cmd:	a TPM command buffer
   348	 * @buflen:	the length of the TPM command buffer
   349	 *
   350	 * Return: same as with tpm_transmit_cmd()
   351	 */
   352	int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
   353	{
   354		struct tpm_buf buf;
   355		int rc;
   356	
   357		chip = tpm_find_get_ops(chip);
   358		if (!chip)
   359			return -ENODEV;
   360	
   361		rc = tpm_buf_init(&buf, 0, 0);
   362		if (rc)
   363			goto out;
   364	
   365		memcpy(buf.data, cmd, buflen);
 > 366		buf.length = buflen;
   367	
   368		rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to a send a command");
   369		tpm_buf_destroy(&buf);
   370	out:
   371		tpm_put_ops(chip);
   372		return rc;
   373	}
   374	EXPORT_SYMBOL_GPL(tpm_send);
   375	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--5yfl4un7vu3iqns5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
LHKxSWTSyD//cSSF8NqGAQA=

--5yfl4un7vu3iqns5--
